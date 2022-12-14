library(jsonlite)

read_file <- function(filename) {
  conn <- file(filename, open='r')
  lines <- readLines(conn)
  close(conn)

  lines
}

parse <- function(lines) {
  result <- list()
  for (line in lines) {
    if (line != '') {
      result <- append(result, list(fromJSON(line, simplifyVector=FALSE)))
    }
  }

  result
}

group_pairs <- function(data) {
  split(data, ceiling(seq_along(data) / 2))
}

INCORRECT <- 0
CORRECT <- 1
INDECISIVE <- 2

eval_order_correctness <- function(left, right) {
  left_length <- length(left)
  right_length <- length(right)

  if (left_length < 1) {
    if (right_length < 1) {
      return(INDECISIVE)
    }
    return(CORRECT)
  }

  for (i in 1:left_length) {
    if (i > right_length) {
      return(INCORRECT)
    }

    left_val <- left[[i]]
    right_val <- right[[i]]

    if (is.numeric(left_val) && is.numeric(right_val)) {
      if (left_val < right_val) {
        return(CORRECT)
      } else if (left_val > right_val) {
        return(INCORRECT)
      }
    } else {
      result <- eval_order_correctness(left_val, right_val)
      if (result < INDECISIVE) {
        return(result)
      }
    }
  }

  if (left_length == right_length) {
    return(INDECISIVE)
  }

  CORRECT
}

is_order_correct <- function(left, right) {
  eval_order_correctness(left, right) == CORRECT
}

count_correct_pairs <- function(pairs) {
  total <- 0
  current <- 1

  for (pair in pairs) {
    if (is_order_correct(pair[[1]], pair[[2]])) {
      total <- total + current
    }
    current <- current + 1
  }

  total
}

sort_packets <- function(packets) {
  pivot <- floor(length(packets) / 2)
  mid <- packets[[pivot]]

  left <- list()
  right <- list()

  for (i in 1:length(packets)) {
    if (i != pivot) {
      packet <- packets[[i]]

      if (is_order_correct(packet, mid)) {
        left <- append(left, list(packet))
      } else {
        right <- append(right, list(packet))
      }
    }
  }

  if (length(left) > 1) {
    left <- sort_packets(left)
  }

  if (length(right) > 1) {
    right <- sort_packets(right)
  }

  result <- list()
  result <- append(result, left)
  result <- append(result, list(mid))
  result <- append(result, right)

  result
}

part1 <- function(data) {
  pairs <- group_pairs(data)

  count_correct_pairs(pairs)
}

part2 <- function(data) {
  divider1 <- list(list(2))
  divider2 <- list(list(6))

  sorted <- sort_packets(append(data, list(divider1, divider2)))

  divider1index <- 0
  divider2index <- 0
  for (i in 1:length(sorted)) {
    elem <- sorted[[i]]
    if (identical(divider1, elem)) {
      divider1index <- i
    } else if (identical(divider2, elem)) {
      divider2index <- i
    }
  }

  divider1index * divider2index
}

data <- parse(read_file('data'))

print(paste("1:", part1(data)))
print(paste("2:", part2(data)))

