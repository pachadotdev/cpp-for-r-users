#include <cpp11.hpp>

using namespace cpp11;
    
[[cpp11::register]] doubles_matrix<> transpose_(doubles_matrix<> X)
{
    // create a matrix R
    int n = X.nrow();
    int m = X.ncol();
    writable::doubles_matrix<> R(m, n);

    // copy X's elements
    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            R(i, j) = X(j, i);
        }
    }

    return R;
}
