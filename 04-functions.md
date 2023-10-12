
# Functions (part 3)

## Logical tests

The following function is the C++ implementation of the R function
`any`, which returns `TRUE` if there is any `TRUE` element in a vector,
and `FALSE` otherwise.

``` cpp
[[cpp11::register]] bool any_cpp_(logicals x) {
  int n = x.size();

  for(int i = 0; i < n; ++i) {
    if (x[i]) {
      return true;
    }
  }
  return false;
}
```

The R equivalent is the following.

``` r
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
```

I also need to add the corresponding auxiliary function for the
documentation.

``` r
#' Return TRUE if any element in a vector is TRUE (C++)
#' @inheritParams all_r
#' @export
any_cpp <- function(x) {
  any_cpp_(x)
}
```

A benchmark of the two functions is the following.

``` r
# just to make sure I am in the right folder when rendering the qmd file
setwd("~/github/cpp-for-r-users/ece244")

load_all()
```

    ℹ Loading ece244

``` r
set.seed(123) # set the seed for reproducibility
x <- rpois(1e6, lambda = 2) # 1,000,000 elements
y <- ifelse(x > 2, TRUE, FALSE)

any(y)
```

    [1] TRUE

``` r
any_cpp(y)
```

    [1] TRUE

``` r
any_r(y)
```

    [1] TRUE

``` r
mark(
    any(y),
    any_cpp(y),
    any_r(y)
)
```

    # A tibble: 3 × 6
      expression      min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 any(y)     313.86ns 327.01ns  2750715.        0B      0  
    2 any_cpp(y)   2.02µs   2.15µs   415748.        0B      0  
    3 any_r(y)     1.17µs   1.52µs   555172.    24.8KB     55.5

## Logical tests (cont’d)

The next function is an alternative C++ implementation of the R function
`which`, that returns the indexes of the `TRUE` elements in a vector.

``` cpp
[[cpp11::register]] integers which_cpp_(cpp11::function pred, doubles x) {
  int n = x.size();
  writable::doubles res;
  int j = 0;

  for(int i = 0; i < n; ++i) {
    if (pred(x[i])) {
      ++j;
      res.push_back(i + 1);
    }
  }

  if (j == 0) {
    return doubles(0);
  } else {
    return res;
  }
}
```

The R equivalent is the following.

``` r
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
```

I also need to add the corresponding auxiliary function for the
documentation.

``` r
#' Return the index of the first TRUE element in a vector (C++)
#' @inheritParams which_r
#' @export
which_cpp <- function(x, y) {
  which_cpp_(x, y)
}
```

A benchmark of the two functions is the following.

``` r
# just to make sure I am in the right folder when rendering the qmd file
setwd("~/github/cpp-for-r-users/ece244")

load_all()
```

    ℹ Loading ece244

``` r
set.seed(123) # set the seed for reproducibility
x <- rpois(1e6, lambda = 2) # 1,000,000 elements

head(which(x > 2))
```

    [1]  2  4  5  8 11 13

``` r
head(which_cpp(function(x) x > 2, x))
```

    [1]  2  4  5  8 11 13

``` r
head(which_r(function(x) x > 2, x))
```

    [1]  2  4  5  8 11 13

``` r
mark(
    which(x > 2),
    which_cpp(function(x) x > 2, x),
    which_r(function(x) x > 2, x)
)
```

    Warning: Some expressions had a GC in every iteration; so filtering is
    disabled.

    # A tibble: 3 × 6
      expression                           min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr>                      <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 which(x > 2)                      10.3ms  13.38ms    76.9      8.86MB    37.5 
    2 which_cpp(function(x) x > 2, x)    1.61s    1.61s     0.621   15.63MB     6.21
    3 which_r(function(x) x > 2, x)   916.24ms 916.24ms     1.09    26.74MB     7.64

Clearly, there is no advantage over `which()` in this case.

## References

- [Get started with
  cpp11](https://cpp11.r-lib.org/articles/cpp11.html#intro)
