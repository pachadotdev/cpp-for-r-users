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

#' Return the mean of the coordinates of a vector (R)
#' @param x numeric vector
#' @export
mean_r <- function(x) {
  sum_r(x) / length(x)
}

#' Return the variance of the coordinates of a vector (R)
#' @param x numeric vector
#' @export
var_r <- function(x) {
  n <- length(x)
  x1 <- 0
  x2 <- 0
  for (i in seq_along(x)) {
    x1 <- x1 + x[i]
    x2 <- x2 + x[i]^2
  }
  (x2 - x1^2 / n) / (n - 1)
}

#' Return the root mean square error (R)
#' @param x numeric vector
#' @param x0 numeric value
#' @export
rmse_r <- function(x, x0) {
  sqrt(sum((x - x0)^2) / length(x))
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

#' Return the sum of the coordinates of a vector (C++)
#' @inheritParams sum_r
#' @param na_rm logical. Should missing values (including `NaN`) be removed?
#' @export
sum2_cpp <- function(x, na_rm = FALSE) {
  sum2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the mean of the coordinates of a vector (C++)
#' @inheritParams sum2_cpp
#' @export
mean2_cpp <- function(x, na_rm = FALSE) {
  mean2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the variance of the coordinates of a vector (C++)
#' @inheritParams sum2_cpp
#' @export
var2_cpp <- function(x, na_rm = FALSE) {
  var2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the root mean square error (C++)
#' @inheritParams rmse_r
#' @param na_rm logical. Should missing values (including `NaN`) be removed?
#' @export
rmse2_cpp <- function(x, x0, na_rm = FALSE) {
  rmse2_cpp_(as.double(x), as.double(x0), na_rm = na_rm)
}

#' Return the cumulative sum of the coordinates of a vector (C++)
#' @param x numeric vector
#' @param na_rm logical. Should missing values (including `NaN`) be removed?
#' @export
cumsum2_cpp <- function(x, na_rm = FALSE) {
  cumsum2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the cumulative product of the coordinates of a vector (C++)
#' @inheritParams cumsum2_r
#' @export
cumprod2_cpp <- function(x, na_rm = FALSE) {
  cumprod2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the cumulative minimum of the coordinates of a vector (C++)
#' @inheritParams cumsum2_r
#' @export
cummin2_cpp <- function(x, na_rm = FALSE) {
  cummin2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the cumulative maximum of the coordinates of a vector (C++)
#' @inheritParams cumsum2_r
#' @export
cummax2_cpp <- function(x, na_rm = FALSE) {
  cummax2_cpp_(as.double(x), na_rm = na_rm)
}
