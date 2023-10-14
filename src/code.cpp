#include <cpp11.hpp>

using namespace cpp11;
namespace writable = cpp11::writable;

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

[[cpp11::register]] double rmse_cpp_(doubles x, double x0) {
  int n = x.size();
  double out;
  for (int i = 0; i < n; ++i) {
    out += pow(x[i] - x0, 2.0);
  }
  return sqrt(out / n);
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

[[cpp11::register]] doubles which_cpp_(cpp11::function pred, doubles x) {
  int n = x.size();
  writable::doubles res;
  int j = 0;

  for (int i = 0; i < n; ++i) {
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

[[cpp11::register]] bool all_cpp_4_(cpp11::logicals x) {
  return std::all_of(x.begin(), x.end(), [](bool x) { return x; });
}

[[cpp11::register]] bool all_cpp_3_(cpp11::logicals x) {
  for (bool i : x) {
    if (i == false) {
      return false;
    }
  }
  return true;
}

[[cpp11::register]] bool all_cpp_2_(cpp11::logicals x) {
  for (int i = 0; i < x.size(); ++i) {
    if (x[i] == false) {
      return false;
    }
  }
  return true;
}

[[cpp11::register]] bool all_cpp_1_(cpp11::logicals x) {
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
