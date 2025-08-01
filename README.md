# C++ Calculator Application

A simple C++ calculator application that uses the Calculator static library.

## Structure

```
application/
├── src/
│   └── main.cpp          # Main application entry point
├── tests/
│   └── test_main.cpp     # Application tests
├── Makefile              # Build configuration
└── .github/workflows/    # CI/CD trigger workflow
```

## Building

The application is built using the centralized build system in the build repository. 
When you push changes to this repository, it automatically triggers a build workflow 
