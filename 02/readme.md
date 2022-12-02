## Info

https://adventofcode.com/2022/day/2

PHP Version: 8

## Codes

- A = rock
- B = paper
- C = scissors

- X = rock
- Y = paper
- Z = scissors

## Scores

- A = X = rock = 1
- B = Y = paper = 2
- C = Z = scissors = 3

- lost = 0
- draw = 3
- won = 6

calc = result + selection

### e.g.

- A Y = 8 = Y(2) + won(6)
- B X = 1 = X(1) + lost(0)
- C Z = 6 = Z(3) + draw(3)
- total = 15
