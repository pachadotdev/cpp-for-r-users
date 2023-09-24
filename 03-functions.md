
# Functions (part 2)

## Euclidean distance between two points

This function returns the distance from a reference point in the real
line to 1,2, …, n points in the real line.

``` cpp
[[cpp11::register]] doubles pdist_cpp_(double x, doubles ys) {
  int n = ys.size();
  writable::doubles out(n);
  for(int i = 0; i < n; ++i) {
    out[i] = sqrt(pow(ys[i] - x, 2.0));
  }
  return out;
}
```

The R equivalent is the following.

``` r
#' Return the euclidean distance from a value to a vector of values (R)
#' @param x numeric
#' @param y numeric vector
#' @export
pdist_r <- function(x, ys) {
  sqrt((x - ys) ^ 2)
}
```

I also need to add the corresponding auxiliary function for the
documentation.

``` r
#' Return the euclidean distance from a value to a vector of values (C++)
#' @inheritParams pdist_r
#' @export
pdist_cpp <- function(x, ys) {
  pdist_cpp_(x, ys)
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
x <- runif(1e3) # 1,000,000 elements

# print the first 10 output's coordinates
head(pdist_cpp(0.5, x))
```

    [1] 0.2052315 0.1916225 0.4295720 0.1031363 0.3465739 0.1249707

``` r
head(pdist_r(0.5, x))
```

    [1] 0.2052315 0.1916225 0.4295720 0.1031363 0.3465739 0.1249707

``` r
mark(
  pdist_cpp(0.5, x),
  pdist_r(0.5, x)
)
```

    # A tibble: 2 × 6
      expression             min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr>        <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 pdist_cpp(0.5, x)     66µs  73.17µs    11723.    7.86KB      0  
    2 pdist_r(0.5, x)      6.9µs   7.36µs   129506.    7.86KB     13.0

Once again, R wins (for now).

## Average the elements of a vector

This function returns the average (or mean) of the elements of a vector.

``` cpp
[[cpp11::register]] double mean_cpp_(doubles x) {
  int n = x.size();
  double y = 0;

  for(int i = 0; i < n; ++i) {
    // y += x[i] / n;
    // replace N divisions with 1 division at the end
    y += x[i];
  }
  
  // return y;
    return y / n;
}
```

The R equivalent is the following.

``` r
#' Return the mean of the coordinates of a vector (R)
#' @param x numeric vector
#' @export
mean_r <- function(x) {
  sum_r(x) / length(x)
}
```

I also need to add the corresponding auxiliary function for the
documentation.

``` r
#' Return the mean of the coordinates of a vector (C++)
#' @inheritParams mean_r
#' @export
mean_cpp <- function(x) {
  mean_cpp_(x)
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
x <- runif(1e3) # 1,000,000 elements

mean(x)
```

    [1] 0.51873

``` r
mean_cpp(x)
```

    [1] 0.51873

``` r
mean_r(x)
```

    [1] 0.51873

``` r
mark(
  mean(x),
  mean_cpp(x),
  mean_r(x)
)
```

    # A tibble: 3 × 6
      expression       min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr>  <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 mean(x)       7.71µs    8.1µs   118985.        0B     11.9
    2 mean_cpp(x)   7.99µs   8.25µs   115648.        0B     11.6
    3 mean_r(x)    42.73µs  44.36µs    20284.    16.6KB      0  

I got ties. My C++ function is clearly faster than my R function, but is
marginally slower than R’s `mean()` function.

## Cumulative sum of the elements of a vector

To be able to create writable vectors, I need to append this below the
namespace declaration (i.e., `using namespace cpp11`).

``` cpp
namespace writable = cpp11::writable;
```

This function returns the cumulative sum of the elements of a vector.

``` cpp
[[cpp11::register]] doubles cumsum_cpp_(doubles x) {
  int n = x.size();
  writable::doubles out(n);

  out[0] = x[0];
  for(int i = 1; i < n; ++i) {
    out[i] = out[i - 1] + x[i];
  }
  return out;
}
```

The R equivalent is the following.

``` r
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
```

I also need to add the corresponding auxiliary function for the
documentation.

``` r
#' Return the cumulative sum of the coordinates of a vector (C++)
#' @inheritParams cumsum_r
#' @export
cumsum_cpp <- function(x) {
  cumsum_cpp_(as.double(x))
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
x <- runif(1e3) # 1,000,000 elements

cumsum(1:3)
```

    [1] 1 3 6

``` r
cumsum_cpp(1:3)
```

    [1] 1 3 6

``` r
cumsum_r(1:3)
```

    [1] 1 3 6

``` r
mark(
    cumsum(x),
    cumsum_cpp(x),
    cumsum_r(x)
)
```

    # A tibble: 3 × 6
      expression         min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr>    <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 cumsum(x)        1.9µs   2.07µs   403521.    7.86KB    40.4 
    2 cumsum_cpp(x)   36.9µs  39.67µs    23808.    7.86KB     4.76
    3 cumsum_r(x)    114.1µs 118.26µs     8291.    35.9KB     0   

My C++ function is in the middle between R’s `cumsum()` and my R
function `cumsum_r()`.

## References

- [Get started with
  cpp11](https://cran.r-project.org/web/packages/cpp11/vignettes/cpp11.html)
