#' @useDynLib ece244, .registration = TRUE
NULL

#' Return 1 (C++)
#' @export
one_cpp <- function() {
  one_cpp_(x)
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

#' Return the euclidean distance from a value to a vector of values (C++)
#' @inheritParams pdist_r
#' @export
pdist_cpp <- function(x, ys) {
  pdist_cpp_(x, ys)
}

#' Return the mean of the coordinates of a vector (C++)
#' @inheritParams mean_r
#' @export
mean_cpp <- function(x) {
  mean_cpp_(x)
}

#' Return the cumulative sum of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cumsum_cpp <- function(x) {
  cumsum_cpp_(as.double(x))
}

#' Return TRUE if any element in a vector is TRUE (C++)
#' @inheritParams all_r
#' @export
any_cpp <- function(x) {
  any_cpp_(x)
}

#' Return the indexes of the elements of a vector that are TRUE (C++)
#' @inheritParams which_r
#' @export
which_cpp <- function(x,y) {
  which_cpp_(x, as.double(y))
}
