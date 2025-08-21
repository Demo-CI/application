# C++ Calculator Application - Changed

A C++17 calculator application demonstrating external static library usage.

## Project Structure

```
application/
├── src/main.cpp          # Main application
├── tests/test_main.cpp   # Application tests
└── Makefile              # Build configuration
```

## Quick Start

```bash
# Build with dependencies
make build-deps

# Build application
make

# Run tests
make test

# Run calculator
make run
```

## Build System

Uses [centralized CI/CD](../build) that automatically:
- Fetches Calculator static library
- Builds and tests the application
- Posts results to PRs

### Automatic Triggers
- **Pull Requests**: Builds automatically trigger when opening/updating PRs
- **Push to main/develop**: Direct commits trigger builds immediately

### Manual JSON Triggers
Post a JSON comment in any Pull Request to customize the build:

```json
{
  "build_type": "debug",
  "save_logs": true,
  "reason": "Testing application with library changes"
}
```

**Parameters:**
- `build_type`: `"release"` (default) or `"debug"`
- `save_logs`: `true` or `false` (default)

**Monitor builds:** [Build Actions](../build/actions)

---
**Related:** [Calculator Library](../static_library) | [Build System](../build) 
