# C++ Calculator Application - Changed

A C++17 calculator application demonstrating usage of external static libraries and centralized CI/CD workflows.

## 📁 Project Structure

```
application/
├── src/
│   └── main.cpp          # Main application entry point
├── tests/
│   └── test_main.cpp     # Application tests
├── include/              # Calculator static library headers
├── lib/                  # Calculator static library source
├── Makefile              # Build configuration with dependency management
└── .github/workflows/    # CI/CD trigger workflow
```

## 🚀 Triggering Builds

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
- `reason`: Custom description (optional)

### Manual Workflow
Go to [Actions](../../actions) → "Trigger Centralized Build" → "Run workflow"

## 📊 Build System

This application uses a **centralized build system** from the [build repository](../build) that:
- Automatically fetches the Calculator static library
- Builds the application with proper linking
- Runs comprehensive tests
- Posts results back to your PR

**Monitor builds:** [Centralized Build Actions](../build/actions)

## 🔧 Local Development

```bash
# Build with automatic dependency fetching
make build-deps

# Build application only (requires library)
make

# Run tests
make test

# Run the calculator
make run
```

---

**🔗 Related:** [Calculator Library](../static_library) | [Centralized Build System](../build) | [Multi-Repo Workspace](../manifest) 
