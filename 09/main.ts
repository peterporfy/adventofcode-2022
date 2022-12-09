
type Pos = { x: number, y: number };

type Rope = Pos[];

enum Direction {
  Up,
  Down,
  Left,
  Right
}

type StepCommand = [Direction, number];

function distance(a: Pos, b: Pos): number {
  return Math.floor(Math.hypot(b.x - a.x, b.y - a.y));
}

function verticalDistance(a: Pos, b: Pos): number {
  return Math.abs(b.y - a.y);
}

function horizontalDistance(a: Pos, b: Pos): number {
  return Math.abs(b.x - a.x);
}

function tailOf(rope: Rope): Pos {
  return rope[rope.length - 1];
}

function stickHorizontal(head: Pos, tail: Pos): number {
  return tail.x < head.x ? head.x - 1 : head.x + 1;
}

function stickVertical(head: Pos, tail: Pos): number {
  return tail.y < head.y ? head.y - 1 : head.y + 1;
}

function runPhysics(rope: Rope): Rope {
  const [head, tail] = rope;

  if (distance(head, tail) <= 1) {
    // no need to stick
    return rope;
  }

  if (head.y === tail.y) {
    return [head, { x: stickHorizontal(head, tail), y: tail.y }];
  }

  if (head.x === tail.x) {
    return [head, { x: tail.x, y: stickVertical(head, tail) }];
  }

  const vd = verticalDistance(head, tail);
  const hd = horizontalDistance(head, tail);

  // diagonal
  if (vd > hd) {
    return [head, { x: head.x, y: stickVertical(head, tail) }];
  } else if (hd > vd) {
    return [head, { x: stickHorizontal(head, tail), y: head.y }];
  } else {
    return [head, { x: stickHorizontal(head, tail), y: stickVertical(head, tail) }];
  }
}

function stepHead(direction: Direction, head: Pos): Pos {
  switch (direction) {
    case Direction.Up:
      return { x: head.x, y: head.y - 1 };
    case Direction.Down:
      return { x: head.x, y: head.y + 1 };
    case Direction.Left:
      return { x: head.x - 1, y: head.y };
    case Direction.Right:
      return { x: head.x + 1, y: head.y };
  }
}

function step(direction: Direction, rope: Rope): Rope {
  const [head, ...tails] = rope;
  const newHead = stepHead(direction, head);

  return tails.reduce((newRope, tail) => {
    const currentHead = tailOf(newRope);
    const [, newTail] = runPhysics([currentHead, tail]);
    return newRope.concat([newTail]);
  }, [newHead]);
}

function createTailTracker(): [Set<string>, (rope: Rope) => Rope] {
  const set = new Set<string>();

  const tracker = function (rope: Rope): Rope {
    const tail = tailOf(rope);
    set.add(`${tail.x}_${tail.y}`);
    return rope;
  };

  return [set, tracker];
}

function execute(rope: Rope, command: StepCommand, fn: (d: Direction, r: Rope) => Rope): Rope {
  const [direction, steps] = command;

  if (steps === 1) {
    return fn(direction, rope);
  } else {
    return execute(fn(direction, rope), [direction, steps - 1], fn);
  }
}

function parseCommands(text: string): StepCommand[] {
  const dirMap = {
    'U': Direction.Up,
    'D': Direction.Down,
    'L': Direction.Left,
    'R': Direction.Right
  };

  return text
    .split('\n')
    .map(line => {
      const [dir, steps] = line.split(' ');
      return [dirMap[dir], parseInt(steps, 10)];
    });
}

// for debug, 5x5 grid
function display(rope: Rope): Rope {
  console.log('----------------------');
  for (let y = -5; y <= 0; y++) {
    let line = '';
    for (let x = 0; x <= 5; x++) {
      const spot = rope.find(pos => pos.x === x && pos.y === y);
      if (spot) {
        const i = rope.indexOf(spot);
        line += `${i === 0 ? 'H' : i}`;
      } else {
        line += '.';
      }
    }
    console.log(line);
  }

  return rope;
}

function ropeOfLength(length: number): Rope {
  return new Array(length).fill(0).map(() => ({ x: 0, y: 0 }));
}

function simulate(ropeLength: number, commands: StepCommand[]): number {
  const initial: Rope = ropeOfLength(ropeLength);

  const [visited, tracker] = createTailTracker();

  const trackedStepper = (direction: Direction, rope: Rope): Rope =>
    tracker(step(direction, rope));
    // display(tracker(step(direction, rope)));

  commands.reduce((rope, command) => execute(rope, command, trackedStepper), initial);

  return visited.size;
}

async function main() {
  const commands = parseCommands(await Deno.readTextFile("./data"));

  const result2 = simulate(2, commands);
  const result10 = simulate(10, commands);

  console.log(`1: ${result2} 2: ${result10}`);
}

main();
