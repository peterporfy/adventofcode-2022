import scala.compiletime.ops.boolean
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Map

type Cave = ArrayBuffer[Array[Boolean]]
type Blueprint = Array[Array[Boolean]]
type Rock = ArrayBuffer[(Int, Int)]

val blueprints = Array(
    Array(
        Array(true, true, true, true)
    ),

    Array(
        Array(false, true),
        Array(true, true, true),
        Array(false, true)
    ),

    // rotated as we have mirrored simulation
    Array(
        Array(true, true, true),
        Array(true, false, false),
        Array(true, false, false)
    ),

    Array(
        Array(true),
        Array(true),
        Array(true),
        Array(true)
    ),

    Array(
        Array(true, true),
        Array(true, true)
    )
)

val verticalAppendGap = 3
val horizontalAppendGap = 2

class CaveBuilder:
    val cave: Cave = ArrayBuffer()
    val caveWidth = 7
    val caveLimit = caveWidth - 1

    def topOfCave(): Int =
        cave.indices.reverse.find(y => cave(y).contains(true)) match {
            case Some(y) => y
            case None => -1
        }

    def rightOfBlueprint(rock: Blueprint): Int =
        rock.map(row => row.indices.reduce((a, b) => a max b)).reduce((a, b) => a max b)

    def appendRow(row: Int): Unit =
        val caveHeight = cave.length - 1

        if (row > caveHeight) {
            val needed = row - caveHeight
            for (_ <- 0 to needed) {
                cave.append(Array.fill(caveWidth) { false })
            }
        }

    def setRock(rock: Rock): Unit =
        for ((y, x) <- rock) {
            cave(y)(x) = true
        }

    def setAir(rock: Rock): Unit =
        for ((y, x) <- rock) {
            cave(y)(x) = false
        }

    def append(blueprint: Blueprint): Rock =
        val topY = topOfCave()
        val maxX = rightOfBlueprint(blueprint)
        val expectedMaxX = caveLimit - horizontalAppendGap
        val topOffset = topY + verticalAppendGap + 1
        val rightOffset = expectedMaxX - maxX
        val rock: Rock = ArrayBuffer()

        for (y <- blueprint.indices) {
            for (x <- blueprint(y).indices) {
                val cell = blueprint(y)(x)
                if (cell) {
                    val newY = y + topOffset
                    val newX = x + rightOffset
                    appendRow( newY)
                    rock.append((newY, newX))
                }
            }
        }

        setRock(rock)

        rock

    def transform(rock: Rock, vector: (Int, Int)): Rock =
        val (dy, dx) = vector
        rock.map { case (y, x) => (y + dy, x + dx) }

    def isAir(rock: Rock): Boolean =
        !rock.exists { case (y, x) => {
            y > cave.length - 1 || y < 0 || x < 0 || x > caveLimit || cave(y)(x)
        }}

    def move(rock: Rock, vector: (Int, Int)): (Boolean, Rock) =
        val nextPosition = transform(rock, vector)
        setAir(rock)

        if (isAir(nextPosition)) {
            setRock(nextPosition)
            (true, nextPosition)
        } else {
            setRock(rock)
            (false, rock)
        }

    def moveDown(rock: Rock): (Boolean, Rock) =
        move(rock, (-1, 0))

    def moveLeft(rock: Rock): (Boolean, Rock) =
        move(rock, (0, -1))

    def moveRight(rock: Rock): (Boolean, Rock) =
        move(rock, (0, 1))

    def display(): Unit =
        println("\n")
        for (y <- 0 to cave.length - 1) {
            var row = ""
            for (x <- 0 to caveLimit) {
                val cell = cave(y)(x)
                if (cell) {
                    row += "0"
                } else {
                    row += "."
                }
            }
            println(row)
        }

class CycleTracker:
    val options: Map[(Int, Int), Boolean] = Map()
    var selected: Option[(Int, Int)] = None
    var height: Long = 0
    var rocks: Long = 0
    var detected = false
    var jumped = false

class Simulation(var rocks: Long, val stream: String):
    val tracker = CycleTracker()
    var currentStream = 0
    var height: Long = 0
    var minHeight: Long = 0
    var currentRock = 0
    var builder = CaveBuilder()

    def tryFastForward(): Unit =
        val key = (currentRock, currentStream)
        if (tracker.options.contains(key)) {
            if (tracker.detected) {
                if (tracker.selected == Some(key) && !tracker.jumped) {
                    val cycleHeight = height - tracker.height
                    val jumpForward = rocks / tracker.rocks
                    rocks = rocks - (jumpForward * tracker.rocks)
                    height = height + (jumpForward * cycleHeight)
                    tracker.jumped = true
                }
            } else {
                tracker.detected = true
                tracker.selected = Some(key)
                tracker.height = height
            }
        }

    def trackCycle(): Unit =
        if (tracker.detected) {
            tracker.rocks += 1
        } else {
            tracker.options((currentRock, currentStream)) = true
        }

    def nextRock(): Unit =
        if (currentRock == blueprints.length - 1) {
            currentRock = 0
        } else {
            currentRock += 1
        }
        rocks -= 1

    def streamPush(rock: Rock): Rock =
        val push = stream(currentStream)
        if (currentStream == stream.length() - 1) {
            currentStream = 0
        } else {
            currentStream += 1
        }

        if (push == '<') {
            val (_, result) = builder.moveRight(rock)
            result
        } else if (push == '>') {
            val (_, result) = builder.moveLeft(rock)
            result
        } else {
            rock
        }

    def simulate(rock: Rock): Unit =
        val (success, result) = builder.moveDown(streamPush(rock))
        if (success) {
            height = minHeight max (height - 1)
            simulate(result)
        }

    def blueprint: Blueprint = blueprints(currentRock)

    def appendNewRock(): Rock =
        minHeight = height
        height += blueprint.length + verticalAppendGap
        builder.append(blueprint)

    def run(): Unit =
        while (rocks > 0) {
            tryFastForward()

            if (rocks > 0) {
                simulate(appendNewRock())
                trackCycle()
            }

            nextRock()
        }

object App:
    def main(args: Array[String]) : Unit =
        val source = scala.io.Source.fromFile("data")
        val stream = try source.mkString finally source.close()

        val sim1 = Simulation(2022, stream)
        val sim2 = Simulation(1000000000000L, stream)

        sim1.run()
        println("1: " + sim1.height)
        sim2.run()
        println("2: " + sim2.height)