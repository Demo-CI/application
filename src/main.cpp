#include "Calculator.h"
#include "MathUtils.h"
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

int main() {
  std::cout << "=== Advanced C++ Calculator Application ===" << std::endl;

  Calculator calc;

  try {
    // Perform basic calculations
    double sum = calc.add(15.5, 24.3);
    double product = calc.multiply(7.0, 8.0);
    double difference = calc.subtract(100.0, 25.5);
    double quotient = calc.divide(84.0, 12.0);

    // Display basic results
    std::cout << "\nBasic Arithmetic Results:" << std::endl;
    std::cout << "15.5 + 24.3 = " << sum << std::endl;
    std::cout << "7.0 * 8.0 = " << product << std::endl;
    std::cout << "100.0 - 25.5 = " << difference << std::endl;
    std::cout << "84.0 / 12.0 = " << quotient << std::endl;

    // Advanced math operations using MathUtils
    std::cout << "\nAdvanced Math Operations:" << std::endl;
    std::cout << "2^10 = " << MathUtils::power(2.0, 10) << std::endl;
    std::cout << "√64 = " << MathUtils::squareRoot(64.0) << std::endl;
    std::cout << "5! = " << MathUtils::factorial(5) << std::endl;
    std::cout << "Is 17 prime? " << (MathUtils::isPrime(17) ? "Yes" : "No")
              << std::endl;

    // Vector operations
    std::vector<double> numbers = {2.5, 8.1, 3.7, 9.2, 1.4, 6.8};
    std::cout << "\nVector Operations on {2.5, 8.1, 3.7, 9.2, 1.4, 6.8}:"
              << std::endl;
    std::cout << "Average: " << MathUtils::average(numbers) << std::endl;
    std::cout << "Maximum: " << MathUtils::maximum(numbers) << std::endl;
    std::cout << "Minimum: " << MathUtils::minimum(numbers) << std::endl;

    // Show calculation history
    std::cout << "\n";
    calc.printHistory();

    std::cout << "\nTotal calculations performed: " << calc.getHistorySize()
              << std::endl;

    // Demonstrate getHistory() function
    std::cout << "\nAccessing calculation history directly:" << std::endl;
    const auto &history = calc.getHistory();
    std::cout << "History contains " << history.size() << " results: ";
    for (size_t i = 0; i < history.size(); ++i) {
      if (i > 0)
        std::cout << ", ";
      std::cout << history[i];
    }
    std::cout << std::endl;

    // Test error handling
    std::cout << "\nTesting Error Handling:" << std::endl;
    try {
      calc.divide(10.0, 0.0);
    } catch (const std::invalid_argument &e) {
      std::cout << "Caught expected error: " << e.what() << std::endl;
    }

    // Demonstrate clearHistory() function
    std::cout << "\nClearing calculation history..." << std::endl;
    calc.clearHistory();
    std::cout << "History size after clearing: " << calc.getHistorySize()
              << std::endl;

  } catch (const std::exception &e) {
    std::cerr << "Error: " << e.what() << std::endl;
    return 1;
  }

  std::cout << "\nApplication completed successfully!" << std::endl;
  return 0;
}
