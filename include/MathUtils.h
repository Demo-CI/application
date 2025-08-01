#ifndef MATH_UTILS_H
#define MATH_UTILS_H

#include <vector>

/**
 * @brief Utility functions for mathematical operations
 */
namespace MathUtils {
/**
 * @brief Calculate the power of a number
 * @param base The base number
 * @param exponent The exponent
 * @return base raised to the power of exponent
 */
double power(double base, int exponent);

/**
 * @brief Calculate the square root of a number
 * @param value The input value
 * @return The square root of the value
 * @throws std::invalid_argument if value is negative
 */
double squareRoot(double value);

/**
 * @brief Calculate the factorial of a number
 * @param n The input number (must be non-negative)
 * @return The factorial of n
 * @throws std::invalid_argument if n is negative
 */
long long factorial(int n);

/**
 * @brief Check if a number is prime
 * @param n The number to check
 * @return true if the number is prime, false otherwise
 */
bool isPrime(int n);

/**
 * @brief Calculate the average of a vector of numbers
 * @param numbers The vector of numbers
 * @return The average of the numbers
 * @throws std::invalid_argument if the vector is empty
 */
double average(const std::vector<double> &numbers);

/**
 * @brief Find the maximum value in a vector
 * @param numbers The vector of numbers
 * @return The maximum value
 * @throws std::invalid_argument if the vector is empty
 */
double maximum(const std::vector<double> &numbers);

/**
 * @brief Find the minimum value in a vector
 * @param numbers The vector of numbers
 * @return The minimum value
 * @throws std::invalid_argument if the vector is empty
 */
double minimum(const std::vector<double> &numbers);
} // namespace MathUtils

#endif // MATH_UTILS_H
