#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <cstddef>
#include <vector>

/**
 * @brief A simple calculator class that performs basic arithmetic operations
 * and maintains a history of calculations.
 */
class Calculator {
private:
  std::vector<double> history;

public:
  /**
   * @brief Default constructor
   */
  Calculator() = default;

  /**
   * @brief Default destructor
   */
  ~Calculator() = default;

  /**
   * @brief Add two numbers
   * @param a First number
   * @param b Second number
   * @return The sum of a and b
   */
  double add(double a, double b);

  /**
   * @brief Multiply two numbers
   * @param a First number
   * @param b Second number
   * @return The product of a and b
   */
  double multiply(double a, double b);

  /**
   * @brief Subtract two numbers
   * @param a First number
   * @param b Second number
   * @return The difference of a and b (a - b)
   */
  double subtract(double a, double b);

  /**
   * @brief Divide two numbers
   * @param a Dividend
   * @param b Divisor
   * @return The quotient of a and b
   * @throws std::invalid_argument if b is zero
   */
  double divide(double a, double b);

  /**
   * @brief Print the calculation history
   */
  void printHistory() const;

  /**
   * @brief Get the number of calculations performed
   * @return The size of the history
   */
  size_t getHistorySize() const;

  /**
   * @brief Clear the calculation history
   */
  void clearHistory();

  /**
   * @brief Get the calculation history
   * @return A const reference to the history vector
   */
  const std::vector<double> &getHistory() const;
};

#endif // CALCULATOR_H
