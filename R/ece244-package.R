#' @useDynLib ece244, .registration = TRUE
NULL

#' Return 1 (C++)
#' @export
one_cpp <- function() {
  one_cpp_()
}

#' Return the sign of a number (C++)
#' @inheritParams sum_r
#' @export
sign_cpp <- function(x) {
  sign_cpp_(x)
}

#' Return the sum of the coordinates of a vector (C++)
#' @inheritParams sum_r
#' @export
sum_cpp <- function(x) {
  sum_cpp_(x)
}

#' Return the mean of the coordinates of a vector (C++)
#' @inheritParams mean_r
#' @export
mean_cpp <- function(x) {
  mean_cpp_(x)
}

#' Return the variance of the coordinates of a vector (C++)
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

#' Return the indexes of the elements of a vector that are TRUE (C++)
#' @inheritParams which_r
#' @export
which_cpp <- function(x, y) {
  which_cpp_(x, as.double(y))
}

#' Return the cumulative sum of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cumsum_cpp <- function(x) {
  cumsum_cpp_(as.double(x))
}

#' Return the cumulative product of the coordinates of a vector (C++)
#' @param x numeric vector
#' @export
cumprod_cpp <- function(x) {
  cumprod_cpp_(as.double(x))
}

#' Return the cumulative minimum of the coordinates of a vector (C++)
#' @param x numeric vector
#' @export
cummin_cpp <- function(x) {
  cummin_cpp_(as.double(x))
}

#' Return the cumulative maximum of the coordinates of a vector (C++)
#' @param x numeric vector
#' @export
cummax_cpp <- function(x) {
  cummax_cpp_(as.double(x))
}

#' Return the first order lagged differences of the coordinates of a vector (C++)
#' @param x numeric vector
#' @export
diff1_cpp <- function(x) {
  diff1_cpp_(as.double(x))
}

#' Return the n-th order lagged differences of the coordinates of a vector (C++)
#' @param x numeric vector
#' @export
diff_cpp <- function(x, lag = 1) {
  diff_cpp_(as.double(x), as.integer(lag))
}

#' Return the n-th order lagged differences of the coordinates of a vector (C++)
#' @param x numeric vector
#' @export
range_cpp <- function(x) {
  range_cpp_(as.double(x))
}
