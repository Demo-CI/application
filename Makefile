# Makefile for C++ Calculator Application

# Compiler settings
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2 -Iinclude
DEBUG_FLAGS = -std=c++17 -Wall -Wextra -g -O0 -Iinclude

# Directories
SRC_DIR = src
LIB_DIR = lib
INCLUDE_DIR = include
TEST_DIR = tests
BUILD_DIR = build

# Target executables
TARGET = calculator
TEST_TARGET = test_runner

# Source files
MAIN_SRC = $(SRC_DIR)/main.cpp
LIB_SOURCES = $(wildcard $(LIB_DIR)/*.cpp)
TEST_SRC = $(TEST_DIR)/test_main.cpp

# Object files
LIB_OBJECTS = $(LIB_SOURCES:$(LIB_DIR)/%.cpp=$(BUILD_DIR)/%.o)
TEST_OBJECTS = $(TEST_SRC:$(TEST_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Default target
all: $(TARGET)

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build library object files
$(BUILD_DIR)/%.o: $(LIB_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build test object files
$(BUILD_DIR)/%.o: $(TEST_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build the main application
$(TARGET): $(MAIN_SRC) $(LIB_OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(MAIN_SRC) $(LIB_OBJECTS)

# Build the test executable
$(TEST_TARGET): $(TEST_OBJECTS) $(LIB_OBJECTS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $(TEST_TARGET) $(TEST_OBJECTS) $(LIB_OBJECTS)

# Debug build
debug: CXXFLAGS = $(DEBUG_FLAGS)
debug: $(TARGET)

# Build and run tests
test: $(TEST_TARGET)
	@echo "Running unit tests..."
	./$(TEST_TARGET)
	@echo "Running application test..."
	./$(TARGET)
	@echo "All tests completed successfully"

# Run the application
run: $(TARGET)
	./$(TARGET)

# Clean build artifacts
clean:
	rm -f $(TARGET) $(TEST_TARGET)
	rm -rf $(BUILD_DIR)

# Install dependencies (for CI)
install-deps:
	@echo "Installing build dependencies..."
	@which $(CXX) > /dev/null || (echo "$(CXX) not found, please install build-essential" && exit 1)
	@echo "Build dependencies are ready"

# Static analysis (if cppcheck is available)
analyze:
	@if command -v cppcheck >/dev/null 2>&1; then \
		echo "Running static analysis..."; \
		cppcheck --enable=all --std=c++17 --suppress=missingIncludeSystem $(SRC_DIR) $(LIB_DIR) $(INCLUDE_DIR); \
	else \
		echo "cppcheck not found, skipping static analysis"; \
	fi

# Format code (if clang-format is available)
format:
	@if command -v clang-format >/dev/null 2>&1; then \
		echo "Formatting code..."; \
		find $(SRC_DIR) $(LIB_DIR) $(INCLUDE_DIR) $(TEST_DIR) -name "*.cpp" -o -name "*.h" | xargs clang-format -i; \
		echo "Code formatting completed"; \
	else \
		echo "clang-format not found, skipping code formatting"; \
	fi

# Check code formatting (requires clang-format)
format-check:
	@if command -v clang-format >/dev/null 2>&1; then \
		echo "Checking code formatting..."; \
		format_issues=$$(find $(SRC_DIR) $(LIB_DIR) $(INCLUDE_DIR) $(TEST_DIR) -name "*.cpp" -o -name "*.h" | xargs clang-format -n -Werror 2>&1); \
		if [ -n "$$format_issues" ]; then \
			echo "Code formatting issues found:"; \
			echo "$$format_issues"; \
			echo "Run 'make format' to fix formatting issues"; \
			exit 1; \
		else \
			echo "Code formatting is correct"; \
		fi; \
	else \
		echo "clang-format not found, skipping format check"; \
	fi

# Show project structure
structure:
	@echo "Project Structure:"
	@tree -I 'build|.git|docs' . || find . -type f -name "*.cpp" -o -name "*.h" -o -name "Makefile" -o -name "*.md" | sort

# Generate documentation (requires doxygen)
docs:
	@if command -v doxygen >/dev/null 2>&1; then \
		echo "Generating documentation..."; \
		doxygen Doxyfile; \
		echo "Documentation generated in docs/html/"; \
		echo "Open docs/html/index.html in your browser"; \
	else \
		echo "doxygen not found, please install: sudo apt-get install doxygen graphviz"; \
	fi

# Clean documentation
clean-docs:
	@echo "Cleaning documentation..."
	@rm -rf docs/

.PHONY: all debug test run clean install-deps analyze format format-check structure docs clean-docs
