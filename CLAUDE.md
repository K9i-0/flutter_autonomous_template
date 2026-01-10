# Flutter Autonomous Development Template

## Project Overview

Template for autonomous Flutter app development with Claude Code.
Claude Code autonomously handles "requirements → design → implementation → testing → self-review".

## Getting Started

### For New App Development

1. Run `/start-development` command
2. Answer requirements questions
3. Review generated REQUIREMENTS.md
4. Approve implementation plan
5. Watch Claude Code build your app

## Autonomous Development Workflow

### Phase 1: Requirements Gathering

Before any implementation, gather requirements using AskUserQuestion:
- App purpose and target users
- Platform targets
- Core features and MVP scope
- Data storage strategy
- Navigation pattern
- Technical requirements

**Output**: `REQUIREMENTS.md`

### Phase 2: Planning (Plan Mode)

Based on requirements:
1. Design architecture and data models
2. Plan implementation order
3. Include testing in the plan
4. Break down into TodoWrite tasks

**Always include testing in plans** - don't end plans at implementation.

### Phase 3: Implementation

Feature-by-feature development:

```
features/{feature_name}/
├── data/
│   ├── models/
│   └── repositories/
├── providers/
└── ui/
    ├── screens/
    └── widgets/
```

### Phase 4: E2E Testing

```
Dart MCP: launch_app → connect_dart_tooling_daemon
    ↓
Maestro: inspect_view_hierarchy (lightweight, prefer this)
    ↓
Maestro: tap_on / input_text
    ↓
Issue found → Fix → hot_reload → Re-verify
    ↓
Maestro: take_screenshot (final confirmation)
```

### Phase 5: Self-Review

Execute `/self-review`:
- Gemini CLI (external model perspective)
- Claude subagent (different context perspective)
- PASS/MINOR/FAIL judgment

### Phase 6: Git Operations

Commit using Conventional Commits format.

## Plan Mode Rules

### Include E2E Testing in All Implementation Plans

When planning feature implementation, include all phases:

1. **Design** - Technology selection, architecture decisions
2. **Implementation** - Code generation/editing
3. **E2E Testing** - Maestro/Dart MCP testing
4. **Self-Review** - `/self-review` skill execution

**Never end a plan at implementation. Include testing.**

### Plan Template

```markdown
## Implementation Plan

### 1. Design
- [ ] Technology research/selection
- [ ] Architecture design

### 2. Implementation
- [ ] Model/Repository layer
- [ ] Provider layer
- [ ] UI layer

### 3. E2E Testing
- [ ] Launch app (Dart MCP: launch_app)
- [ ] UI interaction tests (Maestro: tap_on, input_text)
- [ ] State verification (inspect_view_hierarchy)
- [ ] Screenshot (take_screenshot)

### 4. Self-Review
- [ ] Run /self-review
- [ ] Fix any issues
```

## MCP Tool Selection

### Dart MCP vs CLI

**Principle: Use MCP for DTD-required operations, CLI for everything else**

#### CLI Recommended (More Efficient)

| Operation | Command |
|-----------|---------|
| Device list | `flutter devices` |
| Run tests | `flutter test` |
| Static analysis | `dart analyze` |
| Format | `dart format .` |
| Dependencies | `flutter pub add/get` |
| Build | `flutter build ios/apk` |

#### MCP Required (DTD Connection Needed)

- `launch_app`, `hot_reload`, `hot_restart`
- `get_widget_tree`, `get_runtime_errors`

### Dart MCP vs Maestro MCP

| Purpose | Tool |
|---------|------|
| Launch app | Dart MCP: `launch_app` |
| Connection | Dart MCP: `connect_dart_tooling_daemon` |
| Apply changes | Dart MCP: `hot_reload` / `hot_restart` |
| Widget structure | Dart MCP: `get_widget_tree` |
| Error check | Dart MCP: `get_runtime_errors` |
| UI element list | Maestro: `inspect_view_hierarchy` |
| Tap operation | Maestro: `tap_on` |
| Text input | Maestro: `input_text` |
| Screenshot | Maestro: `take_screenshot` |

## E2E Testing Best Practices

### Efficient Testing Flow

```
✅ Recommended: hierarchy → operate → hierarchy → ... → screenshot (final)
❌ Inefficient: screenshot → operate → screenshot → ...
```

- Use `inspect_view_hierarchy` liberally - it's lightweight and fast
- Use `take_screenshot` only when visual verification is needed

### Semantics for E2E Testing

`Semantics` widget is essential for E2E testing. Both Maestro CLI and MCP recognize elements by accessibility information.

```dart
Semantics(
  identifier: 'todo-fab-add',  // Recognized as resource-id
  label: 'Add new todo',       // Recognized as accessibilityText
  child: FloatingActionButton(...),
)
```

Naming convention:
```
Pattern: {feature}-{element-type}[-{dynamic-id}]

Static: todo-fab-add, search-field, save-button
Dynamic: todo-tile-{uuid}, todo-checkbox-{uuid}
```

## Available Skills & Commands

| Command | Description |
|---------|-------------|
| `/start-development` | Start new development with requirements gathering |
| `/self-review` | Self-review (Gemini CLI + Claude subagent) |
| `/inspect-widget` | Select widget in simulator → investigate/modify |

## Hooks (Auto-execution)

- **After Edit/Write**: Auto-run `dart analyze`
- **Before Stop**: Run test & analysis checks

## Coding Conventions

| Target | Convention |
|--------|------------|
| File names | `snake_case` |
| Class names | `PascalCase` |
| Variables/Functions | `camelCase` |

### Architecture

- State management: Riverpod (AsyncNotifier)
- Persistence: SharedPreferences / Hive
- Pattern: Repository pattern

### Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   ├── l10n/
│   └── dev_tools/
└── features/
    └── {feature_name}/
        ├── data/
        │   ├── models/
        │   └── repositories/
        ├── providers/
        └── ui/
            ├── screens/
            └── widgets/
```

## Development Flow Summary

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

Each phase executed autonomously. Human involvement: instructions and final review only.
