#include <iostream>
#include <string>
#include <vector>

class Calculator {
private:
    std::vector<double> history;

public:
    double add(double a, double b) {
        double result = a + b;
        history.push_back(result);
        return result;
    }

    double multiply(double a, double b) {
        double result = a * b;
        history.push_back(result);
        return result;
    }

    double subtract(double a, double b) {
        double result = a - b;
        history.push_back(result);
        return result;
    }

    void printHistory() const {
        std::cout << "Calculation History:" << std::endl;
        for (size_t i = 0; i < history.size(); ++i) {
            std::cout << "  " << (i + 1) << ": " << history[i] << std::endl;
        }
    }

    size_t getHistorySize() const {
        return history.size();
    }
};

int main() {
    std::cout << "=== Simple C++ Calculator Application ===" << std::endl;
    
    Calculator calc;
    
    // Perform some calculations
    double sum = calc.add(15.5, 24.3);
    double product = calc.multiply(7.0, 8.0);
    double difference = calc.subtract(100.0, 25.5);
    
    // Display results
    std::cout << "\nResults:" << std::endl;
    std::cout << "15.5 + 24.3 = " << sum << std::endl;
    std::cout << "7.0 * 8.0 = " << product << std::endl;
    std::cout << "100.0 - 25.5 = " << difference << std::endl;
    
    // Show calculation history
    std::cout << "\n";
    calc.printHistory();
    
    std::cout << "\nTotal calculations performed: " << calc.getHistorySize() << std::endl;
    std::cout << "Application completed successfully!" << std::endl;
    
    return 0;
}
