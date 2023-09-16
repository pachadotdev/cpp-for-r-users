# Compare with ece244/src/code.cpp:

#' Return 1 (R)
#' @export
one_r <- function() {
    1L
}

#' Return the sign of a number (R)
#' @param x integer
#' @export
sign_r <- function(x) {
  if (x > 0) {
    1
  } else if (x == 0) {
    0
  } else {
    -1
  }
}

#' Return the sum of the coordinates of a vector (R)
#' @param x numeric vector
#' @export
sum_r <- function(x) {
  total <- 0
  for (i in seq_along(x)) {
    total <- total + x[i]
  }
  total
}

#' Return the euclidean distance from a value to a vector of values (R)
#' @param x numeric
#' @param y numeric vector
#' @export
pdist_r <- function(x, ys) {
  sqrt((x - ys) ^ 2)
}

#' Return the mean of the coordinates of a vector (R)
#' @param x numeric vector
#' @export
mean_r <- function(x) {
  sum_r(x) / length(x)
}

#' Return the cumulative sum of the coordinates of a vector (R)
#' @param x numeric vector
#' @export
cumsum_r <- function(x) {
  n <- length(x)
  out <- numeric(n)
  out[1] <- x[1]
  for (i in 2:n) {
    out[i] <- out[i - 1] + x[i]
  }
  out
}

#' Return TRUE if any element in a vector is TRUE (R)
#' @param x logical vector
#' @export
any_r <- function(x) {
  n <- length(x)

  for (i in 1:n) {
    if (x[i]) {
      return(TRUE)
    }
  }
  FALSE
}

#' Return the index of the first TRUE element in a vector (R)
#' @param x predicate function
#' @param y vector of values
#' @export
which_r <- function(x, y) {
  n <- length(y)
  res <- c()
  j <- 0

  for (i in 1:n) {
    if (x(y[i])) {
      j <- j + 1
      res[j] <- i
    }
  }

  if (j == 0) {
    return(0)
  } else {
    return(res)
  }
}
