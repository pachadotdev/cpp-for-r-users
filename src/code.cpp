#include "cpp11.hpp"
#include <numeric>

using namespace cpp11;

[[cpp11::register]] int one_cpp_() { return 1; }

[[cpp11::register]] int sign_cpp_(double x) {
  if (x > 0) {
    return 1;
  } else if (x == 0) {
    return 0;
  } else {
    return -1;
  }
}

[[cpp11::register]] double sum_cpp_(doubles x) {
  int n = x.size();
  double total = 0;
  for (int i = 0; i < n; ++i) {
    total += x[i];
  }
  return total;
}

[[cpp11::register]] double mean_cpp_(doubles x) {
  int n = x.size();
  double y = 0;

  for (int i = 0; i < n; ++i) {
    // y += x[i] / n;
    // replace N divisions with 1 division at the end
    y += x[i];
  }

  // return y;
  return y / n;
}

[[cpp11::register]] double var_cpp_(doubles x) {
  int n = x.size();

  if (n < 2) {
    return NA_REAL;
  }

  double ex = 0;
  for (int i = 0; i < n; ++i) {
    ex += x[i];
  }
  ex /= n;

  double out = 0;
  for (int i = 0; i < n; ++i) {
    out += pow(x[i] - ex, 2);
  }

  return out / (n - 1);
}

[[cpp11::register]] double rmse_cpp_(doubles x, double x0) {
  int n = x.size();
  double y = 0;
  for (int i = 0; i < n; ++i) {
    y += pow(x[i] - x0, 2.0);
  }
  return sqrt(y / n);
}

[[cpp11::register]] doubles cumsum_cpp_(doubles x) {
  int n = x.size();
  writable::doubles out(n);

  out[0] = x[0];
  for (int i = 1; i < n; ++i) {
    out[i] = out[i - 1] + x[i];
  }
  return out;
}

[[cpp11::register]] bool any_cpp_(logicals x) {
  int n = x.size();

  for (int i = 0; i < n; ++i) {
    if (x[i]) {
      return true;
    }
  }
  return false;
}

[[cpp11::register]] integers which_cpp_(logicals x) {
  int n = x.size();
  writable::integers res;
  int j = 0;

  for (int i = 0; i < n; ++i) {
    if (x[i]) {
      ++j;
      res.push_back(i + 1);
    }
  }

  if (j == 0) {
    return integers(0);
  } else {
    return res;
  }
}

[[cpp11::register]] bool all_cpp_4_(logicals x) {
  return std::all_of(x.begin(), x.end(), [](bool x) { return x; });
}

[[cpp11::register]] bool all_cpp_3_(logicals x) {
  for (bool i : x) {
    if (i == false) {
      return false;
    }
  }
  return true;
}

[[cpp11::register]] bool all_cpp_2_(logicals x) {
  for (int i = 0; i < x.size(); ++i) {
    if (x[i] == false) {
      return false;
    }
  }
  return true;
}

[[cpp11::register]] bool all_cpp_1_(logicals x) {
  int n = x.size();
  for (int i = 0; i < n; ++i) {
    if (x[i] == false) {
      return false;
    }
  }
  return true;
}

[[cpp11::register]] cpp11::doubles cumprod_cpp_(cpp11::doubles x) {
  int n = x.size();
  writable::doubles out(n);
  out[0] = x[0];
  for (int i = 1; i < n; ++i) {
    out[i] = out[i - 1] * x[i];
  }
  return out;
}

[[cpp11::register]] cpp11::doubles cumprod_cpp_2_(cpp11::doubles x) {
  writable::doubles out;
  out.push_back(x[0]);
  for (int i = 1; i < x.size(); ++i) {
    out.push_back(out[i - 1] * x[i]);
  }
  return out;
}

[[cpp11::register]] cpp11::doubles cummin_cpp_(cpp11::doubles x) {
  int n = x.size();
  writable::doubles out(n);

  out[0] = x[0];
  for (int i = 1; i < n; ++i) {
    // error: taking address of rvalue [-fpermissive]
    // double* x1 = &out[i - 1];
    double x1 = out[i - 1];

    // error: lvalue required as unary ‘&’ operand
    // double* x2 = &x[i];
    double x2 = x[i];

    out[i] = std::min(x1, x2);
  }
  return out;
}

[[cpp11::register]] cpp11::doubles cummax_cpp_(cpp11::doubles x) {
  int n = x.size();
  writable::doubles out(n);

  out[0] = x[0];
  for (int i = 1; i < n; ++i) {
    // error: taking address of rvalue [-fpermissive]
    // double* x1 = &out[i - 1];
    double x1 = out[i - 1];

    // error: lvalue required as unary ‘&’ operand
    // double* x2 = &x[i];
    double x2 = x[i];

    out[i] = std::max(x1, x2);
  }
  return out;
}

[[cpp11::register]] doubles diff1_cpp_(doubles x) {
  int n = x.size();
  writable::doubles out(n - 1);

  for (int i = 0; i < n - 1; ++i) {
    out[i] = x[i + 1] - x[i];
  }
  return out;
}

[[cpp11::register]] doubles diff_cpp_(doubles x, int lag = 1) {
  int n = x.size();
  writable::doubles out(n - lag);

  for (int i = 0; i < n - lag; ++i) {
    out[i] = x[i + lag] - x[i];
  }
  return out;
}

[[cpp11::register]] doubles range_cpp_(doubles x) {
  int n = x.size();
  double x1 = x[0], x2 = x[0];

  for (int i = 1; i < n; ++i) {
    x1 = std::min(x1, x[i]);
    x2 = std::max(x2, x[i]);
  }

  writable::doubles out(2);
  out[0] = x1;
  out[1] = x2;

  return out;
}

[[cpp11::register]] double sum2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();
  double total = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      total += x[i];
    }
  }
  return total;
}

[[cpp11::register]] double mean2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();

  int m = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      ++m;
    }
  }

  if (m == 0) {
    return NA_REAL;
  }

  double y = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      y += x[i];
    }
  }

  return y / m;
}

[[cpp11::register]] double var2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();

  if (n < 2) {
    return NA_REAL;
  }

  int m = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      ++m;
    }
  }

  if (m < 2) {
    return NA_REAL;
  }

  double ex = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      ex += x[i];
    }
  }
  ex /= m;

  double out = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      out += pow(x[i] - ex, 2);
    }
  }

  return out / (m - 1);
}

[[cpp11::register]] double rmse2_cpp_(doubles x, double x0,
                                      bool na_rm = false) {
  int n = x.size();

  int m = 0;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      ++m;
    }
  }

  if (m == 0) {
    return NA_REAL;
  }

  double out;
  for (int i = 0; i < n; ++i) {
    if (na_rm && ISNAN(x[i])) {
      continue;
    } else {
      out += pow(x[i] - x0, 2.0);
    }
  }
  return sqrt(out / m);
}

[[cpp11::register]] doubles cumsum2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();

  writable::doubles out(n);
  out[0] = x[0];

  if (na_rm == true) {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y2)) {
        out[i] = y1 + 0.0;
      } else {
        if (ISNAN(y1)) {
          out[i] = 0.0 + y2;
        } else {
          out[i] = y1 + y2;
        }
      }
    }
  } else {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y2)) {
        out[i] = NA_REAL;
      } else {
        if (ISNAN(y1)) {
          out[i] = NA_REAL;
        } else {
          out[i] = y1 + y2;
        }
      }
    }
  }

  return out;
}

[[cpp11::register]] doubles cumprod2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();

  writable::doubles out(n);
  out[0] = x[0];

  if (na_rm == true) {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y2)) {
        out[i] = y1 * 1.0;
      } else {
        if (ISNAN(y1)) {
          out[i] = 1.0 * y2;
        } else {
          out[i] = y1 * y2;
        }
      }
    }
  } else {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y2)) {
        out[i] = NA_REAL;
      } else {
        if (ISNAN(y1)) {
          out[i] = NA_REAL;
        } else {
          out[i] = y1 * y2;
        }
      }
    }
  }

  return out;
}

[[cpp11::register]] doubles cummin2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();

  writable::doubles out(n);
  out[0] = x[0];

  if (na_rm == true) {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y1)) {
        out[i] = y2;
      } else {
        out[i] = std::min(y1, y2);
      }
    }
  } else {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y2)) {
        out[i] = NA_REAL;
      } else {
        if (ISNAN(y1)) {
          out[i] = NA_REAL;
        } else {
          out[i] = std::min(y1, y2);
        }
      }
    }
  }

  return out;
}

[[cpp11::register]] doubles cummax2_cpp_(doubles x, bool na_rm = false) {
  int n = x.size();

  writable::doubles out(n);
  out[0] = x[0];

  if (na_rm == true) {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y1)) {
        out[i] = y2;
      } else {
        out[i] = std::max(y1, y2);
      }
    }
  } else {
    for (int i = 1; i < n; ++i) {
      double y1 = out[i - 1], y2 = x[i];
      if (ISNAN(y2)) {
        out[i] = NA_REAL;
      } else {
        if (ISNAN(y1)) {
          out[i] = NA_REAL;
        } else {
          out[i] = std::max(y1, y2);
        }
      }
    }
  }

  return out;
}

// Non-ISO: Use a variable length array
[[cpp11::register]] double squared_sum_non_iso_(integers inp) {
  int size = inp.size();
  double array[size];  // will give a warning, but still compile

  for (int i = 0; i < size; ++i) {
    array[i] = inp[i] * inp[i];
  }

  return std::accumulate(array, array + size, 0.0);
}

// ISO: Use a vector
[[cpp11::register]] double squared_sum_iso_(integers inp) {
  int size = inp.size();
  std::vector<double> vec(size);

  for (int i = 0; i < size; ++i) {
    vec[i] = inp[i] * inp[i];
  }

  return std::accumulate(vec.begin(), vec.end(), 0.0);
}

[[cpp11::register]] integers square_coordinates_(integers x) {
  writable::integers out = x;
  for (int i = 0; i < x.size(); ++i) {
    out[i] = x[i] * x[i];
  }
  return out;
}

[[cpp11::register]] integers square_coordinates2_(writable::integers x) {
  for (int i = 0; i < x.size(); ++i) {
    x[i] = x[i] * x[i];
  }
  return x;
}

[[cpp11::register]] int bad_() {
  int x = 42;     // A valid integer
  int *ptr = &x;  // Pointer to `x`

  // Introduce undefined behavior: alignment issue
  auto misaligned_ptr = reinterpret_cast<long *>(ptr);
  return *misaligned_ptr;  // Read through misaligned pointer
}
