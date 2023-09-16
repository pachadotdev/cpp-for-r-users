
# Setup

## R Setup

I installed the R packages `cpp11` and `usethis`.

``` r
install.packages(c("cpp11", "usethis", "bench"))
```

I created the file `~/.Rprofile` containing the following lines.

``` r
library(devtools)
library(usethis)
library(cpp11)
library(bench)
```

I run `nano ~/.R/Makevars` from bash and then saved with CTRL+O+ENTER
and closed it with CTRL+X. It is the same as creating it with the text
editor from the desktop environment.

Now forget about `devtools::install()`. After reopening your editor,
every time you use RStudio (or VSCode) you just call `install()`, and
the same applies to `usethis::use_*()` and `cpp11::cpp_*()` functions.

## C++ setup

Ubuntu and its derived distributions use `gcc` as the default C++
compiler. Macs use `clang` as the default compiler.

For ECE244 (Programming Fundamentals) we use `clang`, so I installed
`llvm-11` (it also installed `clang-11`), something I did in the past
but then I reinstalled the Operating System and lost the changes.

I downloaded the installation script from the official LLVM repository.

``` bash
cd Downloads
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 11
```

Then I tried to compile a simple example to print a number.

``` cpp
// save this as snippets/01-print-number.cpp

#include <iostream> // required for the cout function

// function to print a message
int main() {
    std::cout << 1 << std::endl;
    return 0;
}
```

I used `g++ 01-print-number.cpp -o 01-print-number`, and I had this
error.

``` bash
fatal error: 'cstdio' file not found
fatal error: 'vector' file not found
cannot find -lc++abi: No such file or directory
```

I had to install additional packages. This took me a few hours searching
on the Internet until I figured it out.

``` bash
sudo apt install g++-11 libc++-11-dev libc++abi-11-dev
```

After this I was able to compile and run the mini program I created.

``` bash
$ cd snippets
$ g++ 01-print-number.cpp -o 01-print-number
$ ./01-print-number 
1
```

## R Setup (part 2)

To be sure that R’s `install()` function uses `clang` and not `gcc` when
compiling my codes, I created the file `~/.R/Makevars`. The contents of
that file are the following.

``` bash
CLANGVER=-11
CLANGLIB=-stdlib=libc++
CXX=$(CCACHE) clang++$(CLANGVER) $(CLANGLIB)
CXX11=$(CCACHE) clang++$(CLANGVER) $(CLANGLIB)
CC=$(CCACHE) clang$(CLANGVER)
SHLIB_CXXLD=clang++$(CLANGVER) $(CLANGLIB)
CXXFLAGS=-Wall -O0 -pedantic
CXX11FLAGS=-Wall -O0 -pedantic
```

For both `CXXFLAGS` and `CXX11FLAGS` I am using `-O0` to avoid
optimization, which is useful for debugging. After the code is working,
I can change it to `-O3` to optimize the compiled code.

If later on I need to compile with `gcc`, I can open `~/.R/Makevars`,
comment all the lines, restart RStudio or VSCode, and run `install()`
again.

If you close RStudio (or VSCode) and open it again, you can check that
the changes were implemented by running
`pkgbuild::check_build_tools(debug = TRUE)`, which should return the
following output.

``` r
Trying to compile a simple C file
Running /usr/lib/R/bin/R CMD SHLIB foo.c
using C compiler: ‘Ubuntu clang version 11.1.0-6’
clang-11 -I"/usr/share/R/include" -DNDEBUG       -fpic  -g -O2 -ffile-prefix-map=/build/r-base-JhpCKt/r-base-4.3.0=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2  -c foo.c -o foo.o
clang-11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -o foo.so foo.o -L/usr/lib/R/lib -lR
```

If I were using `gcc`, the output would have been as in the following
lines.

    Trying to compile a simple C file
    Running /usr/lib/R/bin/R CMD SHLIB foo.c
    using C compiler: ‘gcc (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0’
    gcc -I"/usr/share/R/include" -DNDEBUG       -fpic  -g -O2 -ffile-prefix-map=/build/r-base-JhpCKt/r-base-4.3.0=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2  -c foo.c -o foo.o
    gcc -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -o foo.so foo.o -L/usr/lib/R/lib -lR

The key here is that when I use `clang` the lines start with `clang`,
not with `gcc`.

# References

- [Debugging in R with a single
  command](https://mpadge.github.io/blog/blog012.html)
- [Debugging an R package with
  C++](https://blog.davisvaughan.com/posts/2019-04-05-debug-r-package-with-cpp/)
- [Clang++ missing C++
  header?](https://gatowololo.github.io/blog/clangmissingheaders/)
- [How to I tell RStudio not to ignore the indication to use clang in
  Makevars?](https://stackoverflow.com/questions/76300775/how-to-i-tell-rstudio-not-to-ignore-the-indication-to-use-clang-in-makevars)
- [R’s Makevars: PKG_CXXFLAGS
  vs. PKG_CXX11FLAGS](https://stackoverflow.com/questions/68959897/rs-makevars-pkg-cxxflags-vs-pkg-cxx11flags/68959927#68959927)
- [Debugging memory errors with valgrind and
  gdb](https://reside-ic.github.io/blog/debugging-memory-errors-with-valgrind-and-gdb/)
