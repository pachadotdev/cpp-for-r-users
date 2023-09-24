
# Functions (part 4)

## Are all values true?

In R we can use `all()` to check if all values in a vector are `TRUE`,
as in:

``` r
all(1:5 > 1)
```

    [1] FALSE

Perhaps the easiest C++ implementation is to define a function that
takes a vector of logicals and returns a single logical value after the
boolean result of a loop over the length of the vector.

``` cpp
[[cpp11::register]] bool all_cpp_1_(cpp11::logicals x) {
  int n = x.size();
  for(int i = 0; i < n; ++i) {
    if (x[i] == false) {
      return false;
    }
  }
  return true;
}
```

I can save lines by not defining `n`.

``` cpp
[[cpp11::register]] bool all_cpp_2_(cpp11::logicals x) {
  for (int i = 0; i < x.size(); ++i) {
    if (x[i] == false) {
      return false;
    }
  }
  return true;
}
```

It is also possible to directly define a logical variable `i` inside the
loop.

``` cpp
[[cpp11::register]] bool all_cpp_3_(cpp11::logicals x) {
  for (bool i : x) {
    if (i == false) {
      return false;
    }
  }
  return true;
}
```

Using `std::all_of()` I can do the same thing in one line.

``` cpp
[[cpp11::register]] bool all_cpp_4_(cpp11::logicals x) {
  return std::all_of(x.begin(), x.end(), [](bool x) { return x; });
}
```

To avoid typing `std::` I can use `using namespace std;` at the top of
`src/code.cpp`.

These functions can be directly called from R, in the previous part the
goal was to write a basic documentation and default parameters by using
auxiliary functions.

Now I need to test if the functions work as expected.

``` r
# just to make sure I am in the right folder when rendering the qmd file
setwd("~/github/cpp-for-r-users/ece244")

load_all()
```

    ℹ Loading ece244

``` r
set.seed(123) # set the seed for reproducibility
x <- rpois(1e6, lambda = 2) # 1,000,000 elements

all(x > 2)
```

    [1] FALSE

``` r
all_cpp_1_(x > 2)
```

    [1] FALSE

``` r
all_cpp_2_(x > 2)
```

    [1] FALSE

``` r
all_cpp_3_(x > 2)
```

    [1] FALSE

``` r
all_cpp_4_(x > 2)
```

    [1] FALSE

``` r
# also test the TRUE only case
all(x >= 0)
```

    [1] TRUE

``` r
all_cpp_1_(x >= 0)
```

    [1] TRUE

``` r
all_cpp_2_(x >= 0)
```

    [1] TRUE

``` r
all_cpp_3_(x >= 0)
```

    [1] TRUE

``` r
all_cpp_4_(x >= 0)
```

    [1] TRUE

Now I can care about the benchmarking.

``` r
mark(
  all(x > 2),
  all_cpp_1_(x > 2),
  all_cpp_2_(x > 2),
  all_cpp_3_(x > 2),
  all_cpp_4_(x > 2)
)
```

    # A tibble: 5 × 6
      expression             min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr>        <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 all(x > 2)          4.88ms   5.01ms      192.    3.81MB     16.6
    2 all_cpp_1_(x > 2)   4.89ms   5.01ms      198.    3.81MB     28.3
    3 all_cpp_2_(x > 2)   4.86ms   4.99ms      199.    3.81MB     21.9
    4 all_cpp_3_(x > 2)   4.88ms   4.97ms      201.    3.81MB     34.4
    5 all_cpp_4_(x > 2)   4.86ms   4.94ms      202.    3.81MB     21.9

My functions are marginally better (in terms of speed) than base R.

## Cumulative product

In R we can use `cumprod()` to compute the cumulative product of a
vector.

``` r
cumprod(1:5)
```

    [1]   1   2   6  24 120

The C++ implementation can use the shortcuts from the previous part.

``` cpp
[[cpp11::register]] cpp11::doubles cumprod_cpp_(cpp11::doubles x) {
  int n = x.size();
  writable::doubles out(n);
  out[0] = x[0];
  for(int i = 1; i < n; ++i) {
    out[i] = out[i - 1] * x[i];
  }
  return out;
}
```

I can test the correctness of the function.

``` r
# just to make sure I am in the right folder when rendering the qmd file
setwd("~/github/cpp-for-r-users/ece244")

load_all()
```

    ℹ Loading ece244

``` r
cumprod(1:5)
```

    [1]   1   2   6  24 120

``` r
cumprod_cpp_(1:5)
```

    Error: Invalid input type, expected 'double' actual 'integer'

I need an auxiliary function to cast the input as double.

``` r
#' @export
cumprod_cpp <- function(x) {
  cumprod_cpp_(as.double(x))
}
```

Now I can test the correctness of the function again.

``` r
# just to make sure I am in the right folder when rendering the qmd file
setwd("~/github/cpp-for-r-users/ece244")

load_all()
```

    ℹ Loading ece244

``` r
cumprod(1:5)
```

    [1]   1   2   6  24 120

``` r
cumprod_cpp(1:5)
```

    [1]   1   2   6  24 120

Now I can benchmark the functions.

``` r
set.seed(123) # set the seed for reproducibility
x <- rpois(1e6, lambda = 2) # 1,000,000 elements

mark(
  cumprod(x),
  cumprod_cpp(x)
)
```

    # A tibble: 2 × 6
      expression          min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr>     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 cumprod(x)        3.6ms   4.78ms     172.     15.3MB   269.  
    2 cumprod_cpp(x)   56.6ms  75.03ms      14.1    15.3MB     8.48

The C++ implementation is slower than base R.

## References

- [Get started with
  cpp11](https://cran.r-project.org/web/packages/cpp11/vignettes/cpp11.html)
