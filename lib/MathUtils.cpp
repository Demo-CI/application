#include "../include/MathUtils.h"
#include <algorithm>
#include <cmath>
#include <numeric>
#include <stdexcept>

namespace MathUtils {
double power(double base, int exponent) { return std::pow(base, exponent); }

double squareRoot(double value) {
  if (value < 0.0) {
    throw std::invalid_argument(
        "Cannot calculate square root of negative number");
  }
  return std::sqrt(value);
}

long long factorial(int n) {
  if (n < 0) {
    throw std::invalid_argument(
        "Factorial is not defined for negative numbers");
  }
  if (n == 0 || n == 1) {
    return 1;
  }

  long long result = 1;
  for (int i = 2; i <= n; ++i) {
    result *= i;
  }
  return result;
}

bool isPrime(int n) {
  if (n <= 1) {
    return false;
  }
  if (n <= 3) {
    return true;
  }
  if (n % 2 == 0 || n % 3 == 0) {
    return false;
  }

  for (int i = 5; i * i <= n; i += 6) {
    if (n % i == 0 || n % (i + 2) == 0) {
      return false;
    }
  }
  return true;
}

double average(const std::vector<double> &numbers) {
  if (numbers.empty()) {
    throw std::invalid_argument("Cannot calculate average of empty vector");
  }

  double sum = std::accumulate(numbers.begin(), numbers.end(), 0.0);
  return sum / numbers.size();
}

double maximum(const std::vector<double> &numbers) {
  if (numbers.empty()) {
    throw std::invalid_argument("Cannot find maximum of empty vector");
  }
  return *std::max_element(numbers.begin(), numbers.end());
}

double minimum(const std::vector<double> &numbers) {
  if (numbers.empty()) {
    throw std::invalid_argument("Cannot find minimum of empty vector");
  }
  return *std::min_element(numbers.begin(), numbers.end());
}
} // namespace MathUtils
