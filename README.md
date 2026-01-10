# Flutter Autonomous Development Template

A template for autonomous Flutter app development powered by Claude Code.

## Overview

This template enables Claude Code to autonomously handle the full development cycle:
- Requirements gathering through interactive questions
- Architecture design and planning
- Feature-by-feature implementation
- E2E testing with Maestro/Dart MCP
- Self-review before completion
- Git operations with Conventional Commits

## Quick Start

### 1. Use this template

```bash
# Clone or use as GitHub template
git clone https://github.com/your-username/flutter_autonomous_template.git my_app
cd my_app

# Run setup
./scripts/setup.sh
```

### 2. Start development with Claude Code

```bash
claude

# In Claude Code, run:
/start-development
```

### 3. Answer requirement questions

Claude Code will ask questions about:
- App purpose and target users
- Platform targets (iOS/Android/Web)
- Core features and MVP scope
- Data storage strategy
- Navigation pattern
- Technical requirements

### 4. Let Claude Code build your app

After requirements are confirmed:
1. Claude enters Plan Mode to design implementation
2. You approve the plan
3. Claude implements features with E2E testing
4. Claude performs self-review before marking complete
5. Changes are committed using Conventional Commits

## Project Structure

```
flutter_autonomous_template/
├── .claude/
│   ├── settings.json              # Permissions & hooks
│   ├── hooks/
│   │   ├── post-edit-analyze.sh   # Auto-analyze after edits
│   │   └── pre-stop-check.sh      # Check before stop
│   ├── skills/
│   │   ├── self-review/           # Multi-perspective code review
│   │   ├── flutter-mobile-automation/  # E2E testing guide
│   │   ├── flutter-ui-design/     # UI design guidelines
│   │   └── requirements-gathering/  # Requirements collection
│   └── commands/
│       ├── inspect-widget.md      # Widget inspection workflow
│       └── start-development.md   # Development start workflow
├── .mcp.json                      # MCP server configuration
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   │   ├── theme/                 # Modern theme setup
│   │   ├── l10n/                  # Localization
│   │   └── dev_tools/             # Debug utilities
│   └── features/                  # Feature modules
├── test/
├── docs/
├── scripts/
│   └── setup.sh
├── CLAUDE.md                      # Project rules for Claude
├── pubspec.yaml
└── README.md
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/start-development` | Start new development with requirements gathering |
| `/self-review` | Multi-perspective code review (Gemini + Claude subagent) |
| `/inspect-widget` | Select and inspect widget in simulator |

## MCP Servers

This template uses three MCP servers:

- **dart-mcp**: Flutter development integration (hot reload, widget tree, etc.)
- **maestro**: E2E testing and UI automation
- **mobile-mcp**: Mobile device control (optional)

## Requirements

- Flutter 3.10+
- Dart 3.x
- Claude Code CLI
- Maestro CLI (for E2E testing)
- Gemini CLI (for self-review)

## Development Workflow

```
/start-development
    ↓
Requirements Gathering (AskUserQuestion)
    ↓
REQUIREMENTS.md generated
    ↓
Plan Mode (EnterPlanMode)
    ↓
Implementation (TodoWrite tracking)
    ↓
E2E Testing (Dart MCP + Maestro MCP)
    ↓
Self-Review (/self-review)
    ↓
Git Commit (Conventional Commits)
```

## Customization

### Adding new skills

Create a new directory in `.claude/skills/` with a `SKILL.md` file following the frontmatter format:

```markdown
---
name: skill-name
description: Description of what this skill does.
---

# Skill Name

Content here...
```

### Modifying permissions

Edit `.claude/settings.json` to add or remove tool permissions.

### Adjusting hooks

Modify scripts in `.claude/hooks/` to change auto-execution behavior.

## Documentation

- [Setup Guide](docs/SETUP.md)
- [Workflow Details](docs/WORKFLOW.md)
- [Requirements Template](docs/REQUIREMENTS_TEMPLATE.md)

## License

MIT
