#include "../include/Calculator.h"
#include "../include/MathUtils.h"
#include <cassert>
#include <cmath>
#include <iostream>

void testCalculator() {
  std::cout << "Testing Calculator class..." << std::endl;

  Calculator calc;

  // Test basic operations
  assert(calc.add(2.0, 3.0) == 5.0);
  assert(calc.subtract(10.0, 4.0) == 6.0);
  assert(calc.multiply(3.0, 4.0) == 12.0);
  assert(calc.divide(15.0, 3.0) == 5.0);

  // Test history
  assert(calc.getHistorySize() == 4);

  // Test division by zero
  try {
    calc.divide(1.0, 0.0);
    assert(false); // Should not reach here
  } catch (const std::invalid_argument &) {
    // Expected exception
  }

  std::cout << "Calculator tests passed!" << std::endl;
}

void testMathUtils() {
  std::cout << "Testing MathUtils functions..." << std::endl;

  // Test power function
  assert(MathUtils::power(2.0, 3) == 8.0);
  assert(MathUtils::power(5.0, 0) == 1.0);

  // Test square root
  assert(MathUtils::squareRoot(9.0) == 3.0);
  assert(MathUtils::squareRoot(0.0) == 0.0);

  // Test factorial
  assert(MathUtils::factorial(0) == 1);
  assert(MathUtils::factorial(1) == 1);
  assert(MathUtils::factorial(5) == 120);

  // Test prime checking
  assert(MathUtils::isPrime(2) == true);
  assert(MathUtils::isPrime(17) == true);
  assert(MathUtils::isPrime(4) == false);
  assert(MathUtils::isPrime(1) == false);

  // Test vector operations
  std::vector<double> numbers = {1.0, 2.0, 3.0, 4.0, 5.0};
  assert(MathUtils::average(numbers) == 3.0);
  assert(MathUtils::maximum(numbers) == 5.0);
  assert(MathUtils::minimum(numbers) == 1.0);

  // Test error cases
  try {
    MathUtils::squareRoot(-1.0);
    assert(false); // Should not reach here
  } catch (const std::invalid_argument &) {
    // Expected exception
  }

  try {
    MathUtils::factorial(-1);
    assert(false); // Should not reach here
  } catch (const std::invalid_argument &) {
    // Expected exception
  }

  std::cout << "MathUtils tests passed!" << std::endl;
}

int main() {
  std::cout << "=== Running Unit Tests ===" << std::endl;

  try {
    testCalculator();
    testMathUtils();

    std::cout << "\nAll tests passed successfully!" << std::endl;
    return 0;
  } catch (const std::exception &e) {
    std::cerr << "Test failed with error: " << e.what() << std::endl;
    return 1;
  }
}
