# Functions

## Creating a dummy package

From RStudio (or VSCode) we can create a new package by running `create_package("~/github/cpp-for-r-users/linalg")`. This will create a new folder with the name `linalg`.  Then I run `use_cpp11()` to add the required files to use C++ code within R.

I run `use_r("linalg-package")` to create a new R script file named `linalg-package.R` within the `R` folder, and added the following code to it.

```r
#' @useDynLib linalg, .registration = TRUE
NULL
```

The `usethis` skeleton also created the file `src/code.cpp` for me. I added a simple function to transpose a matrix to it, by replacing the file contents by the following lines.

```cpp
#include <cpp11.hpp>

using namespace cpp11;
    
[[cpp11::register]] doubles_matrix<> transpose_(doubles_matrix<> X)
{
    // create a matrix R
    int n = X.nrow();
    int m = X.ncol();
    writable::doubles_matrix<> R(m, n);

    // copy main diagonal
    for (int i = 0; i < n; i++)
    {
        R(i, i) = X(i, i);
    }

    // swap the elements outside the diagonal
    for (int i = 0; i < n; i++)
    {
        for (int j = i + 1; j < m; j++)
        {
            double tmp = X(i, j);
            R(i, j) = X(j, i);
            R(j, i) = tmp;
        }
    }

    return R;
}
```

Important: Within R, I do not need to create a `main()` function in C++.

In order to export the function, I added the following lines to `linalg-package.R`.

```r
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
```

To install the recently created package, I run the following lines in the R console.

```r
clean_dll()
cpp_register()
document()
install()
```

Then I tested the functions.

```r
> X <- matrix(as.numeric(1:4), nrow = 2, ncol = 2)

> X
     [,1] [,2]
[1,]    1    3
[2,]    2    4

> transpose(X)
     [,1] [,2]
[1,]    1    2
[2,]    3    4
```

If I would have passed `1:4` instead of `as.numeric(1:4)` to `matrix()`, I would have obtained the following error message.

```r
> transpose(X)
Error: Invalid input type, expected 'double' actual 'integer'
```

This is because I declared the function to accept a `doubles_matrix<>` as input, and not an `integers_matrix<>`.

## References 

* [Get started with cpp11](https://cran.r-project.org/web/packages/cpp11/vignettes/cpp11.html)
* [Transposes, permutations, Spaces R^n](https://www.youtube.com/watch?v=JibVXBElKL0&pp=ygUcZ2lsYmVydCBzdHJhbmcgdHJhbnNwb3NpdGlvbg%3D%3D)
