
# Functions

## Creating a dummy package

From RStudio (or VSCode) we can create a new package by running
`create_package("~/github/cpp-for-r-users/ece244")`. This will create a
new folder with the name `ece244`. Then I run `use_cpp11()` to add the
required files to use C++ code within R.

I run `use_r("ece244-package")` to create a new R script file named
`ece244-package.R` within the `R` folder under `ece244`, and added the
following code to it.

``` r
#' @useDynLib ece244, .registration = TRUE
NULL
```

## Print a number

The `usethis` skeleton also created the file `src/code.cpp` for me. I
added a simple function to print the number 1.

``` cpp
#include <cpp11.hpp>

using namespace cpp11;
    
[[cpp11::register]] int one_cpp_() {
    return 1;
}
```

Within R, I do not need to create a `main()` function in C++.

The R version of this is.

``` r
#' Return 1 (R)
#' @export
one_r <- function() {
    1L
}
```

In order to export the function, I added the following lines to
`ece244-package.R`, this allows me to document the function and
eventually define default values for the arguments.

``` r
#' Return 1 (C++)
#' @export
one_cpp <- function() {
  one_cpp_(x)
}
```

## Number’s sign

A more complicated function is one that returns the sign of a number.

``` cpp
[[cpp11::register]] int sign_cpp_(double x) {
    if (x > 0) {
        return 1;
    } else if (x == 0) {
        return 0;
    } else {
        return -1;
    }
}
```

``` r
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
```

I also have to add the corresponding auxiliary function for the
documentation.

``` r
#' Return the sign of a number (C++)
#' @inheritParams sum_r
#' @export
sign_cpp <- function(x) {
  sign_cpp_(x)
}
```

## Sum the elements of a vector

I know R provides the `sum()` function, but I want to create this
function just for the sake of the example.

The following function returns the sum of the elements of a vector.

``` cpp
[[cpp11::register]] double sum_cpp_(doubles x) {
  int n = x.size();
  double total = 0;
  for(int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total;
}
```

``` r
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
```

I also have to add the corresponding auxiliary function for the
documentation.

``` r
#' Return the sum of the coordinates of a vector (C++)
#' @inheritParams sum_r
#' @export
sum_cpp <- function(x) {
  sum_cpp_(x)
}
```

## Testing functions

To test the recently created package, I run the following lines in the R
console.

``` r
# just to make sure I am in the right folder when rendering the qmd file
setwd("~/github/cpp-for-r-users/ece244")

cpp_register()
load_all()
```

    ℹ Loading ece244
    ℹ 14 functions decorated with [[cpp11::register]]

    ✔ generated file 'cpp11.R'

    ✔ generated file 'cpp11.cpp'

    ℹ Re-compiling ece244 (debug build)

    ── R CMD INSTALL ───────────────────────────────────────────────────────────────
    * installing *source* package ‘ece244’ ...
    ** using staged installation
    ** libs
    using C++ compiler: ‘g++ (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0’
    using C++11
    g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I'/home/pacha/R/x86_64-pc-linux-gnu-library/4.3/cpp11/include'     -fpic  -g -O2 -ffile-prefix-map=/build/r-base-MHXHhT/r-base-4.3.1=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2  -UNDEBUG -Wall -pedantic -g -O0 -c cpp11.cpp -o cpp11.o
    g++ -std=gnu++11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -o ece244.so code.o cpp11.o -L/usr/lib/R/lib -lR
    installing to /tmp/RtmpKmDWqJ/devtools_install_6abc7e999706/00LOCK-ece244/00new/ece244/libs
    ** checking absolute paths in shared objects and dynamic libraries
    * DONE (ece244)

Then I tested the sum functions’ speed.

``` r
x <- runif(1e3) # 1,000,000 elements

sum(x)
```

    [1] 480.949

``` r
sum_cpp(x)
```

    [1] 480.949

``` r
sum_r(x)
```

    [1] 480.949

``` r
mark(
    sum(x),
    sum_cpp(x),
    sum_r(x)
)
```

    # A tibble: 3 × 6
      expression      min   median `itr/sec` mem_alloc `gc/sec`
      <bch:expr> <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    1 sum(x)       2.02µs   2.04µs   478778.        0B     0   
    2 sum_cpp(x)  12.63µs  12.95µs    71029.        0B     7.10
    3 sum_r(x)    41.85µs  43.03µs    22762.    18.7KB     0   

This is not computationally efficient (i.e., see the median time, which
is median execution time for repeated runs), which is fine because the
purpose of this example is to show how to create a package with C++
code. The code optimizations were deactived in the `Makevars` file and
the improvements to the code will come later.

## Installing the package

To document and install this as a proper R package that I can call with
`library(ece244)`, I need to add a few more things.

``` r
cpp_register()
document()
install()
```

## References

- [Get started with
  cpp11](https://cpp11.r-lib.org/articles/cpp11.html#intro)
