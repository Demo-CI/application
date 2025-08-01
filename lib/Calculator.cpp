#include "../include/Calculator.h"
#include <iostream>
#include <stdexcept>

double Calculator::add(double a, double b) {
  double result = a + b;
  history.push_back(result);
  return result;
}

double Calculator::multiply(double a, double b) {
  double result = a * b;
  history.push_back(result);
  return result;
}

double Calculator::subtract(double a, double b) {
  double result = a - b;
  history.push_back(result);
  return result;
}

double Calculator::divide(double a, double b) {
  if (b == 0.0) {
    throw std::invalid_argument("Division by zero is not allowed");
  }
  double result = a / b;
  history.push_back(result);
  return result;
}

void Calculator::printHistory() const {
  std::cout << "Calculation History:" << std::endl;
  for (size_t i = 0; i < history.size(); ++i) {
    std::cout << "  " << (i + 1) << ": " << history[i] << std::endl;
  }
}

size_t Calculator::getHistorySize() const { return history.size(); }

void Calculator::clearHistory() { history.clear(); }

const std::vector<double> &Calculator::getHistory() const { return history; }
