# Setup Guide

## Prerequisites

### Required

1. **Flutter SDK** (3.10+)
   ```bash
   flutter --version
   # Flutter 3.10.0 or higher
   ```

2. **Dart SDK** (included with Flutter)

3. **Claude Code CLI**
   ```bash
   # Install via npm
   npm install -g @anthropic-ai/claude-code

   # Or via Homebrew
   brew install anthropic/tap/claude-code
   ```

### Recommended

4. **Maestro CLI** (for E2E testing)
   ```bash
   curl -fsSL "https://get.maestro.mobile.dev" | bash
   ```

5. **Gemini CLI** (for self-review)
   ```bash
   # Install Gemini CLI for multi-model code review
   npm install -g @google/gemini-cli
   ```

6. **mise** (for version management)
   ```bash
   curl https://mise.run | sh
   ```

## Installation

### Option 1: Use as GitHub Template

1. Click "Use this template" on GitHub
2. Clone your new repository
3. Run setup script

### Option 2: Clone Directly

```bash
git clone https://github.com/your-username/flutter_autonomous_template.git my_app
cd my_app
./scripts/setup.sh
```

## Setup Script

The setup script (`scripts/setup.sh`) performs:

1. Flutter dependencies installation (`flutter pub get`)
2. Hook script permission setup
3. Git initialization (if needed)
4. Initial analysis run

## Configuration

### .claude/settings.json

This file contains:
- Tool permissions for Claude Code
- Hook configurations
- Plugin settings

Default permissions include:
- Flutter/Dart CLI commands
- Git operations
- MCP server tools (dart-mcp, maestro)
- Web search/fetch for documentation

### .mcp.json

MCP server configuration:
- `dart-mcp`: Flutter development tools
- `maestro`: E2E testing automation
- `mobile-mcp`: Device control (optional)

### Local Settings

Create `.claude/settings.local.json` for user-specific settings:

```json
{
  "permissions": {
    "additionalDirectories": [
      "/Users/<your-username>/.maestro/tests"
    ]
  }
}
```

This file is gitignored by default.

## Verification

After setup, verify everything works:

```bash
# Check Flutter
flutter doctor

# Check Maestro
maestro --version

# Check Claude Code
claude --version

# Start Claude Code
claude
```

## Troubleshooting

### Flutter pub get fails

```bash
# Clear cache and retry
flutter pub cache repair
flutter pub get
```

### Maestro not found

```bash
# Add to PATH
export PATH="$PATH:$HOME/.maestro/bin"
```

### MCP servers not connecting

1. Check `.mcp.json` configuration
2. Ensure required CLIs are installed
3. Restart Claude Code

### Hooks not executing

```bash
# Ensure scripts are executable
chmod +x .claude/hooks/*.sh
```

## Next Steps

After setup is complete:

1. Start Claude Code: `claude`
2. Run `/start-development` to begin
3. Answer requirement questions
4. Let Claude Code build your app!
