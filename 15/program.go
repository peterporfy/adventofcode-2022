package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"regexp"
	"sort"
	"strconv"
)

type Beacon struct {
	X, Y int
}

type Sensor struct {
	X, Y    int
	Closest Beacon
}

type RowCoverage struct {
	startX, endX int
	covered      bool
}

func parseNum(num string) int {
	i, err := strconv.Atoi(num)
	if err != nil {
		return 0
	} else {
		return i
	}
}

func parse(file string) []Sensor {
	readFile, err := os.Open(file)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer readFile.Close()
	scanner := bufio.NewScanner(readFile)

	scanner.Split(bufio.ScanLines)

	matcher, _ := regexp.Compile("Sensor at x=(\\-?[\\d]+), y=(\\-?[\\d]+): closest beacon is at x=(\\-?[\\d]+), y=(\\-?[\\d]+)")
	var sensors []Sensor

	for scanner.Scan() {
		line := scanner.Text()
		match := matcher.FindStringSubmatch(line)

		sensor := Sensor{parseNum(match[1]), parseNum(match[2]), Beacon{parseNum(match[3]), parseNum(match[4])}}
		sensors = append(sensors, sensor)
	}

	return sensors
}

func diff(a, b int) int {
	return int(math.Abs(float64(a) - float64(b)))
}

func distance(sensor Sensor, beacon Beacon) int {
	distance := diff(beacon.X, sensor.X) + diff(beacon.Y, sensor.Y)
	return distance
}

func knownCoverageAtRow(sensor Sensor, row int) RowCoverage {
	dist := distance(sensor, sensor.Closest)
	verticalDistance := diff(sensor.Y, row)

	if verticalDistance > dist {
		return RowCoverage{0, 0, false}
	}

	coverage := dist - verticalDistance

	return RowCoverage{sensor.X - coverage, sensor.X + coverage, true}
}

func tuningFrequency(x, y int) int {
	return x*4000000 + y
}

func scanPart1(sensors []Sensor, rowToInspect int) {
	minX := 0
	maxX := 0
	beaconsInRow := map[Beacon]bool{}

	for _, sensor := range sensors {
		coverage := knownCoverageAtRow(sensor, rowToInspect)

		if coverage.covered {
			minX = int(math.Min(float64(minX), float64(coverage.startX)))
			maxX = int(math.Max(float64(maxX), float64(coverage.endX)))
		}

		if sensor.Closest.Y == rowToInspect {
			beaconsInRow[sensor.Closest] = true
		}
	}

	possible := maxX - minX + 1 - len(beaconsInRow) // +1 as that's a valid position
	fmt.Println("Part 1:", possible)
}

func scanPart2(sensors []Sensor, rowBoundary int) {
	for row := 0; row <= rowBoundary; row++ {

		var segmentsCovered []RowCoverage

		for _, sensor := range sensors {
			coverage := knownCoverageAtRow(sensor, row)

			if coverage.covered {
				segmentsCovered = append(segmentsCovered, coverage)
			}
		}

		sort.Slice(segmentsCovered, func(i, j int) bool {
			return segmentsCovered[i].startX < segmentsCovered[j].startX
		})

		stitchingPoint := math.MinInt
		for _, segment := range segmentsCovered {
			// only start to evaluate at 0 as possible position >0
			if stitchingPoint > 0 {
				column := stitchingPoint + 1
				// there is only one possible position so when there is a gap in segment buildup then we found it
				if column < segment.startX {
					fmt.Println("Part 2:", tuningFrequency(column, row))
					break
				}
			}

			if stitchingPoint < segment.endX {
				stitchingPoint = segment.endX
			}
		}
	}
}

func scan(file string, rowToInspect int, rowBoundary int) {
	sensors := parse(file)

	scanPart1(sensors, rowToInspect)
	scanPart2(sensors, rowBoundary)
}

func main() {
	// scan("testdata", 10, 20)
	scan("data", 2000000, 4000000)
}
