# Compare with ece244/src/code.cpp:

#' @useDynLib ece244, .registration = TRUE
NULL

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
#' @inheritParams sum_r
#' @export
mean_r <- function(x) {
  sum_r(x) / length(x)
}

#' Return the variance of the coordinates of a vector (R)
#' @inheritParams sum_r
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
#' @inheritParams sum_r
#' @param x0 numeric value
#' @export
rmse_r <- function(x, x0) {
  sqrt(sum((x - x0)^2) / length(x))
}

#' Return the cumulative sum of the coordinates of a vector (R)
#' @inheritParams sum_r
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

#' Return the cumulative product of a vector (R)
#' @param x numeric vector
#' @export
cumprod_r <- function(x) {
  n <- length(x)
  out <- numeric(n)
  out[1] <- x[1]
  for (i in 2:n) {
    out[i] <- out[i - 1] * x[i]
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

#' Return the indexes of the TRUE elements in a vector (R)
#' @param x vector of values
#' @export
which_r <- function(x) {
  n <- length(x)
  res <- c()
  j <- 0

  for (i in 1:n) {
    if (x[i]) {
      res <- c(res, i)
      j <- j + 1
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
#' @export
sum_cpp <- function(x) {
  sum_cpp_(x)
}

#' Return the mean of a vector (C++)
#' @inheritParams mean_r
#' @export
mean_cpp <- function(x) {
  mean_cpp_(x)
}

#' Return the variance of a vector (C++)
#' @inheritParams var_r
#' @export
var_cpp <- function(x) {
  var_cpp_(x)
}

#' Return the root mean square error (C++)
#' @inheritParams rmse_r
#' @export
rmse_cpp <- function(x, x0) {
  rmse_cpp_(x, x0)
}

#' Return TRUE if any element in a vector is TRUE (C++)
#' @inheritParams any_r
#' @export
any_cpp <- function(x) {
  any_cpp_(x)
}

#' Return the index of the TRUE elements in a vector (C++)
#' @inheritParams which_r
#' @export
which_cpp <- function(x) {
  which_cpp_(x)
}

#' Return the cumulative sum of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cumsum_cpp <- function(x) {
  cumsum_cpp_(as.double(x))
}

#' Return the cumulative product of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cumprod_cpp <- function(x) {
  cumprod_cpp_(as.double(x))
}

#' Return the cumulative minimum of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cummin_cpp <- function(x) {
  cummin_cpp_(as.double(x))
}

#' Return the cumulative maximum of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cummax_cpp <- function(x) {
  cummax_cpp_(as.double(x))
}

#' Return the n-th order lagged differences of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @param lag integer
#' @export
diff_cpp <- function(x, lag = 1) {
  diff_cpp_(as.double(x), as.integer(lag))
}

#' Return the range of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
range_cpp <- function(x) {
  range_cpp_(as.double(x))
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
#' @inheritParams sum2_cpp
#' @export
cumprod2_cpp <- function(x, na_rm = FALSE) {
  cumprod2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the cumulative minimum of the coordinates of a vector (C++)
#' @inheritParams sum2_cpp
#' @export
cummin2_cpp <- function(x, na_rm = FALSE) {
  cummin2_cpp_(as.double(x), na_rm = na_rm)
}

#' Return the cumulative maximum of the coordinates of a vector (C++)
#' @inheritParams sum2_cpp
#' @export
cummax2_cpp <- function(x, na_rm = FALSE) {
  cummax2_cpp_(as.double(x), na_rm = na_rm)
}

#' @title Bad function
#' @description This function has a sneaky sanitizer error
#' @export
#' @examples
#' bad()
bad <- function() {
  bad_()
}
