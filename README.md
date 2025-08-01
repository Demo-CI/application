# C++ Calculator Application

[![Build and Test C++ Application](https://github.com/Demo-CI/application/actions/workflows/build.yml/badge.svg)](https://github.com/Demo-CI/application/actions/workflows/build.yml)
[![Generate Doxygen Documentation](https://github.com/Demo-CI/application/actions/workflows/documentation.yml/badge.svg)](https://github.com/Demo-CI/application/actions/workflows/documentation.yml)

A modular C++ calculator application with advanced mathematical functions, designed to demonstrate best practices in C++ development and continuous integration with GitHub Actions.

## Features

- **Basic Arithmetic**: Addition, subtraction, multiplication, division
- **Advanced Math Functions**: Power, square root, factorial, prime checking
- **Vector Operations**: Average, maximum, minimum calculations
- **Calculation History**: Track and display calculation results
- **Error Handling**: Robust exception handling for invalid operations
- **Modular Design**: Separated into header files and implementation libraries
- **Unit Testing**: Comprehensive test suite
- **Static Analysis**: Code quality checks with cppcheck
- **Code Formatting**: Automated formatting with clang-format

## Project Structure

```
├── src/                    # Source files
│   └── main.cpp           # Main application entry point
├── include/               # Header files
│   ├── Calculator.h       # Calculator class declaration
│   └── MathUtils.h        # Math utility functions declaration
├── lib/                   # Library implementations
│   ├── Calculator.cpp     # Calculator class implementation
│   └── MathUtils.cpp      # Math utility functions implementation
├── tests/                 # Test files
│   └── test_main.cpp      # Unit tests
├── build/                 # Build artifacts (auto-generated)
├── .github/
│   └── workflows/
│       ├── build.yml        # Main CI/CD pipeline
│       └── documentation.yml # Documentation generation
├── Makefile              # Build configuration
├── README.md             # This file
└── .gitignore           # Git ignore rules
```

## Building the Application

### Prerequisites

- C++17 compatible compiler (g++ or clang++)
- Make build system
- Linux environment (Ubuntu recommended)

### Build Commands

```bash
# Build the application (Release mode)
make

# Build in Debug mode with debugging symbols
make debug

# Build and run unit tests
make test

# Run the application
make run

# Clean build artifacts
make clean

# Show project structure
make structure

# Run static analysis (requires cppcheck)
make analyze

# Format code (requires clang-format)
make format

# Generate documentation (requires doxygen)
make docs

# Clean documentation
make clean-docs
```

### Advanced Build Options

```bash
# Build with specific compiler
make CXX=clang++

# Build with custom flags
make CXXFLAGS="-std=c++17 -Wall -Wextra -O3 -DNDEBUG -Iinclude"

# Build only the test executable
make test_runner
```

## Running the Application

After building, run the calculator:

```bash
./calculator
```

Expected output:
```
=== Advanced C++ Calculator Application ===

Basic Arithmetic Results:
15.5 + 24.3 = 39.8
7.0 * 8.0 = 56
100.0 - 25.5 = 74.5
84.0 / 12.0 = 7

Advanced Math Operations:
2^10 = 1024
√64 = 8
5! = 120
Is 17 prime? Yes

Vector Operations on {2.5, 8.1, 3.7, 9.2, 1.4, 6.8}:
Average: 5.28333
Maximum: 9.2
Minimum: 1.4

Calculation History:
  1: 39.8
  2: 56
  3: 74.5
  4: 7

Total calculations performed: 4

Testing Error Handling:
Caught expected error: Division by zero is not allowed

Application completed successfully!
```

## Running Tests

```bash
# Run all tests
make test

# Run only unit tests
./test_runner
```

## Documentation

### API Documentation

Complete API documentation is automatically generated using Doxygen and is available online:

- **📖 [Online Documentation](https://Demo-CI.github.io/application/)** - Browse the complete API reference
- **📥 [Download Documentation](https://github.com/Demo-CI/application/actions/workflows/documentation.yml)** - Download the latest documentation artifacts

The documentation includes:
- **Class diagrams** with UML visualization
- **Call graphs** showing function relationships
- **Include dependency graphs**
- **Detailed API reference** with examples
- **Source code browsing** with syntax highlighting

### Generating Documentation Locally

To generate documentation locally:

```bash
# Install Doxygen and Graphviz
sudo apt-get install doxygen graphviz

# Generate documentation
doxygen Doxyfile

# Open documentation
firefox docs/html/index.html
```

## API Documentation

### Calculator Class

```cpp
class Calculator {
public:
    double add(double a, double b);           // Addition
    double subtract(double a, double b);      // Subtraction
    double multiply(double a, double b);      // Multiplication
    double divide(double a, double b);        // Division (throws on division by zero)
    void printHistory() const;               // Print calculation history
    size_t getHistorySize() const;           // Get number of calculations
    void clearHistory();                     // Clear calculation history
    const std::vector<double>& getHistory() const; // Get history vector
};
```

### MathUtils Namespace

```cpp
namespace MathUtils {
    double power(double base, int exponent);           // Power calculation
    double squareRoot(double value);                   // Square root
    long long factorial(int n);                        // Factorial
    bool isPrime(int n);                              // Prime number check
    double average(const std::vector<double>& numbers); // Vector average
    double maximum(const std::vector<double>& numbers); // Vector maximum
    double minimum(const std::vector<double>& numbers); // Vector minimum
}
```

## GitHub Actions CI/CD

This project includes comprehensive GitHub Actions workflows:

### Build and Test Workflow
- **Multi-Configuration**: Builds in both Debug and Release modes
- **Multi-OS Testing**: Tests on multiple Ubuntu versions
- **Unit Testing**: Runs comprehensive test suite
- **Static Analysis**: Performs code quality checks with cppcheck
- **Performance Testing**: Runs optimized builds for performance validation
- **Artifact Upload**: Stores build artifacts for download

### Documentation Workflow
- **Dependency**: Only runs after successful build completion
- **Automatic Generation**: Creates comprehensive API documentation
- **GitHub Pages**: Deploys to live website (main branch only)
- **Artifact Upload**: Provides downloadable documentation
- **Smart Triggering**: Only generates docs for working code

### Workflow Triggers

**Build Workflow:**
- Push to `main` or `develop` branches
- Pull requests to `main` branch

**Documentation Workflow:**
- Triggered automatically after successful build completion
- Manual triggering available via workflow_dispatch

## Development

### Adding New Features

1. Add function declarations to appropriate header files in `include/`
2. Implement functions in corresponding source files in `lib/`
3. Add unit tests in `tests/test_main.cpp`
4. Update documentation in README.md
5. Test locally with `make test`
6. Commit and push to trigger CI/CD pipeline

### Code Quality

- Follow C++17 standards
- Use meaningful variable and function names
- Add proper documentation comments
- Handle errors with exceptions
- Write unit tests for new functionality
- Run `make format` before committing
- Ensure `make analyze` passes without warnings

### Local Development Workflow

```bash
# 1. Make changes to source files
# 2. Build and test
make clean && make test

# 3. Check code formatting
make format

# 4. Run static analysis
make analyze

# 5. Commit and push
git add .
git commit -m "Your commit message"
git push
```