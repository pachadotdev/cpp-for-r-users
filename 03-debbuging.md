# Debugging the package

In order to access debugging symbols, I created a new `Makevars` file within the `src` folder, and added the following lines.

```bash
CXX_STD = CXX11
PKG_CPPFLAGS = -UDEBUG -g
```

Then I reinstalled the package compiled with debugging symbols, and in bash I run `R -d lldb-11`.

I shouldn't generally leave the `-g` flag on in a Makevars file, that will insert trace symbols in the compiled binary, both increasing compilation times (often by a large margin), and creating larger binaries. Once the package is compiled and I am sure that it works properly, I need to remove the `PKG_CPPFLAGS = -UDEBUG -g` line.

# A more complex example

I created a package containing a set of simple functions to obtain the Ordinary Least Squares (OLS) estimator by calling a C++ function that calls other C++ functions. My approach was to create one function per step, which meant to create one function to obtain $X^tX$, another for $(X^tX)^{-1}$ which consisted in implementing the Gauss-Jordan method to invert a matrix, another for $X^tY$ and then call each of those functions to obtain $\hat{\beta} = (X^tX)^{-1}(X^tY)$.

This implementation is extremely naive, but it is enough to show how to use C++ code within R. Please see it from my [GitHub profile](https://github.com/pachadotdev/cpp11dummyols).

A good challenge would be to implement the QR decomposition used by the `lm()` function in R and use it to obtain the OLS estimator in C++. This would require some effort, but [here](http://madrury.github.io/jekyll/update/statistics/2016/07/20/lm-in-R.html) you can find a good starting point.

In any case, it would be extremely hard to beat the performance of the `lm()` function in R, which has some internals written in C, and how computationally robust `lm()` is means another feature that is hard to beat.

# References

* [Debugging in R with a single command](https://mpadge.github.io/blog/blog012.html)
* [Debugging an R package with C++](https://blog.davisvaughan.com/posts/2019-04-05-debug-r-package-with-cpp/)
* [R's Makevars: PKG_CXXFLAGS vs. PKG_CXX11FLAGS](https://stackoverflow.com/questions/68959897/rs-makevars-pkg-cxxflags-vs-pkg-cxx11flags/68959927#68959927)
* [Debugging memory errors with valgrind and gdb](https://reside-ic.github.io/blog/debugging-memory-errors-with-valgrind-and-gdb/)
* [A Deep Dive Into How R Fits a Linear Model](http://madrury.github.io/jekyll/update/statistics/2016/07/20/lm-in-R.html)
