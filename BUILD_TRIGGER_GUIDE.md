# Build Trigger Guide

## Overview

This guide explains how to trigger centralized builds for the application and static library repositories using different methods, including JSON comments during code reviews.

## Trigger Methods

### 1. Automatic PR Triggers

Builds are automatically triggered when:
- A new pull request is opened targeting `main` or `develop`
- An existing pull request is updated (new commits pushed)
- A pull request is reopened

### 2. Manual Workflow Dispatch

You can manually trigger builds from the GitHub Actions UI:

1. Go to the **Actions** tab in the repository
2. Select **"Trigger Centralized Build"** workflow
3. Click **"Run workflow"**
4. Configure parameters:
   - **Reason**: Custom reason for the trigger
   - **Build Type**: Choose between `debug` or `release`
   - **Save Logs**: Enable/disable log saving

### 3. JSON Comment Triggers (Code Review)

During code reviews, developers can post JSON comments to trigger custom builds with specific configurations.

#### JSON Comment Format

Post a comment in a pull request with the following JSON structure:

```json
{
  "build_type": "debug",
  "save_logs": true,
  "reason": "Testing new feature with debug build"
}
```

Or use a code block format:

````markdown
```json
{
  "build_type": "release",
  "save_logs": false,
  "reason": "Performance testing"
}
```
````

#### JSON Parameters

| Parameter    | Type    | Required | Default   | Description                           |
|-------------|---------|----------|-----------|---------------------------------------|
| `build_type` | string  | No       | `release` | Build configuration (`debug`/`release`) |
| `save_logs`  | boolean | No       | `false`   | Whether to save detailed build logs   |
| `reason`     | string  | No       | Auto-generated | Custom reason for the build trigger |

#### Valid Values

- **build_type**: 
  - `"debug"` - Enables debug symbols, assertions, and verbose logging
  - `"release"` - Optimized build with minimal debug information
- **save_logs**:
  - `true` or `"true"` - Save complete build logs as artifacts
  - `false` or `"false"` - Standard logging only
- **reason**: Any descriptive string

#### Examples

**Debug Build with Logs:**
```json
{
  "build_type": "debug",
  "save_logs": true,
  "reason": "Investigating memory leak in feature X"
}
```

**Release Build for Performance Testing:**
```json
{
  "build_type": "release",
  "save_logs": false,
  "reason": "Performance benchmark before merge"
}
```

**Minimal Configuration:**
```json
{
  "build_type": "debug"
}
```

#### Comment Reactions

The workflow will automatically add reactions to your comments:
- ✅ **👍 (+1)**: JSON was parsed successfully and build triggered
- ❓ **😕 (confused)**: Invalid JSON format or parsing error

## Build Configuration Details

### Debug Builds
- Include debug symbols and assertions
- Enable verbose logging
- Disable optimizations for easier debugging
- Longer build times but better for development

### Release Builds  
- Optimized for performance and size
- Minimal debug information
- Production-ready binaries
- Faster execution but harder to debug

### Log Saving
When `save_logs: true` is specified:
- Complete build logs are saved as GitHub Actions artifacts
- Logs include detailed compilation output, test results, and timing information
- Artifacts are retained for 90 days (default GitHub retention)
- Useful for debugging build issues or performance analysis

## Workflow Behavior

1. **Comment Detection**: The workflow monitors for new comments on pull requests
2. **JSON Parsing**: Attempts to extract and validate JSON from comment body
3. **Parameter Validation**: Ensures valid values and applies defaults
4. **Build Trigger**: Sends configuration to centralized build system
5. **Feedback**: Adds reaction emojis to indicate success or failure

## Troubleshooting

### Common Issues

**No build triggered after comment:**
- Ensure the comment is on a pull request (not regular issue)
- Verify JSON syntax is valid
- Check that the comment contains `{` and `}` characters

**Invalid JSON reaction:**
- Use a JSON validator to check syntax
- Ensure proper quotes around strings
- Verify no trailing commas

**Build not using expected configuration:**
- Check the centralized build workflow handles the new parameters
- Verify the repository dispatch payload includes build configuration

### Debug Steps

1. Check the workflow run in the Actions tab
2. Look for the "Parse JSON comment" step output
3. Verify the comment parsing succeeded
4. Check the repository dispatch payload in logs

## Integration with Centralized Build

The build configuration is passed to the centralized build system via repository dispatch with these additional payload fields:

- `build_type`: The requested build type (`debug`/`release`)
- `save_logs`: Whether to save detailed logs (`true`/`false`)
- `commit_message`: Includes the custom reason if provided

The centralized build workflow should handle these parameters to customize the build process accordingly.
