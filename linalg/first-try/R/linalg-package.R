#' @useDynLib linalg, .registration = TRUE
NULL

#' Transpose a matrix
#' @export
#' @param X numeric matrix
#' @return numeric matrix
#' @examples
#' set.seed(1234)
#' X <- matrix(rnorm(4), nrow = 2, ncol = 2)
#' X
#' transpose(X)
transpose <- function(X) {
  transpose_(X)
}
