# Creating a dummy package

From RStudio (or VSCode) we can create a new package by running `create_package("~/linalg")`. This will create a new folder with the name `linalg`.  Then I run `use_cpp11()` to add the required files to use C++ code within R.

I run `use_r("cpp11dummypackage-package")` to create a new R script file named `cpp11dummypackage-package.R` within the `R` folder, and added the following code to it.

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
    int NX = X.nrow();
    int MX = X.ncol();

    writable::doubles_matrix<> R(MX, NX);

    for (int i = 0; i < MX; i++)
    {
        for (int j = 0; j < NX; j++)
        {
            R(i, j) = X(j, i);
        }
    }

    return R;
}
```

This will create a new matrix, which is a problem (i.e., think about the memory usage)

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

I tested the functions after running `cpp11_register()` and `load_all()`.

```r
> set.seed(1234)

> X <- matrix(rnorm(4), nrow = 2, ncol = 2)

> X
           [,1]      [,2]
[1,] -1.2070657  1.084441
[2,]  0.2774292 -2.345698

> transpose(X)
          [,1]       [,2]
[1,] -1.207066  0.2774292
[2,]  1.084441 -2.3456977
```

If I would have passed `1:4` instead of `rnorm(4)` to `matrix()`, I would have obtained the following error message.

```r
> transpose(X)
Error: Invalid input type, expected 'double' actual 'integer'
```

This is because I declared the function to accept a `doubles_matrix<>` as input, and not an `integers_matrix<>`.

To install the recently created package, I run the following lines in the R console.

```r
clean_dll()
cpp_register()
document()
install()
```
