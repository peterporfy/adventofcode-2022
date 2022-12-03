## Info

https://adventofcode.com/2022/day/2

PHP Version: 8

## Codes

- A = rock
- B = paper
- C = scissors

### 1
- X = rock
- Y = paper
- Z = scissors

### 2
- X = lose
- Y = draw
- Z = win

## Scores

- A = X = rock = 1
- B = Y = paper = 2
- C = Z = scissors = 3

- lost = 0
- draw = 3
- won = 6

calc = result + selection

### example

#### 1
- A Y = 8 = Y(2) + won(6)
- B X = 1 = X(1) + lost(0)
- C Z = 6 = Z(3) + draw(3)
- total = 15

#### 2
- A Y = 4 = Y(A(1)) + draw(3)
- B X = 1 = X(A(1)) + lost(0)
- C Z = 7 = Z(A(1)) + won(6)
- total = 12
