# Makefile for C++ Calculator Application with External Library Support

# Compiler settings
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2 -Iinclude
DEBUG_FLAGS = -std=c++17 -Wall -Wextra -g -O0 -Iinclude

# External library settings - auto-detect repo vs standalone
ifeq ($(wildcard ../.repo),../.repo)
    # We're in a repo workspace - use repo-managed dependency
    EXTERNAL_LIB_DIR = ../libs/calculator
    DEPENDENCY_MODE = repo
    $(info ✅ Detected repo workspace - using repo-managed static library)
else
    # Standalone mode - use traditional dependency fetching
    EXTERNAL_LIB_DIR = deps/static_library
    DEPENDENCY_MODE = standalone
    $(info ⚠️  Standalone mode - using external dependency fetching)
endif

EXTERNAL_LIB_INCLUDE = $(EXTERNAL_LIB_DIR)/include
EXTERNAL_LIB_PATH = $(EXTERNAL_LIB_DIR)/lib/libcalculator.a
EXTERNAL_LIB_NAME = calculator

# Update flags to include external library
CXXFLAGS += -I$(EXTERNAL_LIB_INCLUDE)
DEBUG_FLAGS += -I$(EXTERNAL_LIB_INCLUDE)

# Directories
SRC_DIR = src
INCLUDE_DIR = include
TEST_DIR = tests
BUILD_DIR = build

# Target executables
TARGET = calculator
TEST_TARGET = test_runner

# Source files (no local lib sources since we use external library)
MAIN_SRC = $(SRC_DIR)/main.cpp
TEST_SRC = $(TEST_DIR)/test_main.cpp

# Object files
TEST_OBJECTS = $(TEST_SRC:$(TEST_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Default target
all: check-deps $(TARGET)

# Check if external library dependency exists
check-deps:
	@echo "Checking external library dependencies..."
	@if [ ! -d "$(EXTERNAL_LIB_DIR)" ]; then \
		echo "❌ External library not found at $(EXTERNAL_LIB_DIR)"; \
		echo "Run 'make fetch-deps' to download the library"; \
		exit 1; \
	fi
	@if [ ! -f "$(EXTERNAL_LIB_PATH)" ]; then \
		echo "❌ Library file not found: $(EXTERNAL_LIB_PATH)"; \
		echo "Run 'make build-deps' to build the library"; \
		exit 1; \
	fi
	@echo "✅ External library dependencies satisfied"

# Fetch external library dependency
fetch-deps:
	@echo "Fetching external library dependency..."
	@if [ ! -d "$(EXTERNAL_LIB_DIR)" ]; then \
		mkdir -p deps; \
		cp -r ../static_library $(EXTERNAL_LIB_DIR); \
		echo "✅ External library copied from local directory"; \
	else \
		echo "✅ External library already exists"; \
	fi

# Build external library dependency (mode-aware)
build-deps:
ifeq ($(DEPENDENCY_MODE),repo)
	@echo "Building repo-managed static library dependency..."
	@if [ ! -d "$(EXTERNAL_LIB_DIR)" ]; then \
		echo "❌ Repo-managed library not found at $(EXTERNAL_LIB_DIR)"; \
		echo "Make sure you're in a properly synced repo workspace"; \
		exit 1; \
	fi
	@cd $(EXTERNAL_LIB_DIR) && make clean && make static
	@echo "✅ Repo-managed external library built successfully"
else
	@$(MAKE) build-deps-standalone
endif

# Build external library dependency (standalone mode)
build-deps-standalone: fetch-deps
	@echo "Building standalone external library dependency..."
	@cd $(EXTERNAL_LIB_DIR) && make clean && make static
	@echo "✅ Standalone external library built successfully"

# Repo-specific build target (for repo workspaces)
build-deps-repo:
	@echo "Building repo-managed dependencies..."
	@if [ ! -d "../libs/calculator" ]; then \
		echo "❌ Not in a repo workspace or library not synced"; \
		echo "Run 'repo sync' from workspace root"; \
		exit 1; \
	fi
	@cd ../libs/calculator && make clean && make static
	@echo "✅ Repo-managed dependencies built successfully"

# Default target
all: check-deps $(TARGET)

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build test object files
$(BUILD_DIR)/%.o: $(TEST_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build the main application with external library
$(TARGET): $(MAIN_SRC) $(EXTERNAL_LIB_PATH) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(MAIN_SRC) $(EXTERNAL_LIB_PATH)

# Build the test executable with external library
$(TEST_TARGET): $(TEST_OBJECTS) $(EXTERNAL_LIB_PATH) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $(TEST_TARGET) $(TEST_OBJECTS) $(EXTERNAL_LIB_PATH)

# Debug build
debug: CXXFLAGS = $(DEBUG_FLAGS)
debug: check-deps $(TARGET)

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

# Clean build artifacts (keep external dependencies)
clean:
	rm -f $(TARGET) $(TEST_TARGET)
	rm -rf $(BUILD_DIR)

# Clean everything including dependencies
clean-all: clean
	rm -rf deps/

# Update external library dependency
update-deps:
	@echo "Updating external library dependency..."
	@if [ -d "$(EXTERNAL_LIB_DIR)" ]; then \
		cd $(EXTERNAL_LIB_DIR) && git pull origin main; \
		make build-deps; \
	else \
		make build-deps; \
	fi
	@echo "✅ External library updated"

# Install dependencies (for CI) - includes external library
install-deps:
	@echo "Installing build dependencies and external library..."
	@which $(CXX) > /dev/null || (echo "$(CXX) not found, please install build-essential" && exit 1)
	make build-deps
	@echo "Build dependencies and external library are ready"

# Static analysis (if cppcheck is available) - updated for external lib structure
analyze:
	@if command -v cppcheck >/dev/null 2>&1; then \
		echo "Running static analysis..."; \
		cppcheck --enable=all --std=c++17 --suppress=missingIncludeSystem $(SRC_DIR) $(TEST_DIR); \
	else \
		echo "cppcheck not found, skipping static analysis"; \
	fi

# Format code (if clang-format is available) - updated for new structure
format:
	@if command -v clang-format >/dev/null 2>&1; then \
		echo "Formatting code..."; \
		find $(SRC_DIR) $(TEST_DIR) -name "*.cpp" -o -name "*.h" | xargs clang-format -i; \
		echo "Code formatting completed"; \
	else \
		echo "clang-format not found, skipping code formatting"; \
	fi

# Check code formatting (requires clang-format) - updated for new structure
format-check:
	@if command -v clang-format >/dev/null 2>&1; then \
		echo "Checking code formatting..."; \
		format_issues=$$(find $(SRC_DIR) $(TEST_DIR) -name "*.cpp" -o -name "*.h" | xargs clang-format -n -Werror 2>&1); \
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

# Show project structure with external dependencies
structure:
	@echo "Application Project Structure (with External Dependencies):"
	@tree -I 'build|.git|docs|deps' . || find . -type f -name "*.cpp" -o -name "*.h" -o -name "Makefile" -o -name "*.md" | sort
	@if [ -d "deps" ]; then \
		echo "\nExternal Dependencies:"; \
		tree deps/ || ls -la deps/; \
	fi

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

.PHONY: all debug test run clean clean-all install-deps analyze format format-check structure docs clean-docs check-deps fetch-deps build-deps build-deps-standalone build-deps-repo update-deps
