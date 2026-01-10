# Development Workflow

## Overview

The autonomous development workflow consists of six phases:

1. Requirements Gathering
2. Planning (Plan Mode)
3. Implementation
4. E2E Testing
5. Self-Review
6. Git Operations

## Phase 1: Requirements Gathering

### Trigger

Run `/start-development` command or start a new feature request.

### Process

Claude Code asks structured questions using `AskUserQuestion`:

1. **Basic Information**
   - App purpose
   - Target users
   - Platform targets

2. **Feature Requirements**
   - Core features (3-5)
   - MVP scope
   - Data storage method

3. **Screen Design**
   - Expected screen count
   - Navigation pattern

4. **Technical Requirements**
   - External API integrations
   - Authentication method
   - Offline support

### Output

`REQUIREMENTS.md` file is generated with all specifications.

## Phase 2: Planning (Plan Mode)

### Trigger

After requirements are confirmed, Claude Code enters Plan Mode.

### Process

1. Enter Plan Mode with `EnterPlanMode`
2. Analyze requirements
3. Design architecture
4. Create implementation plan with:
   - Feature breakdown
   - Data model design
   - Implementation order
   - **E2E testing included**

### Important

Plans must ALWAYS include testing. Don't end plans at implementation.

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
- [ ] Launch app (Dart MCP)
- [ ] UI interaction tests (Maestro)
- [ ] State verification
- [ ] Screenshot verification

### 4. Self-Review
- [ ] Run /self-review
- [ ] Fix any issues
```

### Output

User approves plan with `ExitPlanMode`.

## Phase 3: Implementation

### Process

Feature-by-feature development:

1. Break down into tasks with `TodoWrite`
2. Implement each task
3. Auto-analyze runs after each edit (hook)
4. Mark tasks complete as they finish

### Architecture

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

### Key Practices

- Add `Semantics` for E2E testability
- Use Riverpod AsyncNotifier for state
- Follow naming conventions
- Minimal, focused changes

## Phase 4: E2E Testing

### Workflow

```
Dart MCP: launch_app → connect_dart_tooling_daemon
    ↓
Maestro: inspect_view_hierarchy (lightweight)
    ↓
Maestro: tap_on / input_text
    ↓
Issue found → Fix → hot_reload → Re-verify
    ↓
Maestro: take_screenshot (final confirmation)
```

### Efficient Pattern

```
✅ Recommended: hierarchy → operate → hierarchy → ... → screenshot (final)
❌ Inefficient: screenshot → operate → screenshot → ...
```

### Tool Selection

| Purpose | Tool |
|---------|------|
| Launch app | Dart MCP: `launch_app` |
| DTD connection | Dart MCP: `connect_dart_tooling_daemon` |
| Apply changes | Dart MCP: `hot_reload` |
| Widget structure | Dart MCP: `get_widget_tree` |
| UI element list | Maestro: `inspect_view_hierarchy` |
| Tap operation | Maestro: `tap_on` |
| Text input | Maestro: `input_text` |
| Screenshot | Maestro: `take_screenshot` |

## Phase 5: Self-Review

### Trigger

Before marking tasks complete or when `/self-review` is invoked.

### Process

1. **Collect changes**
   ```bash
   git diff HEAD
   ```

2. **Gemini CLI review** (external model perspective)
   - Code quality
   - Bugs & errors
   - Design patterns

3. **Claude subagent review** (different context perspective)
   - Same review points
   - Project-specific checks

4. **Result integration**
   | Judgment | Condition | Action |
   |----------|-----------|--------|
   | PASS | Both LGTM | Complete task |
   | MINOR | Minor issues only | Warning, then complete |
   | FAIL | Critical issues | Fix and re-review |

5. **Feedback loop**
   - Fix issues
   - Re-run review
   - Repeat until PASS

## Phase 6: Git Operations

### Commit Format

Conventional Commits:

```
type(scope): description

Co-Authored-By: Claude <noreply@anthropic.com>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Tests
- `chore`: Maintenance

### Process

1. Check changes: `git status`, `git diff`
2. Stage relevant files
3. Create commit with proper message
4. Push when feature is complete

## Automation Features

### Hooks

- **Post Edit/Write**: Auto `dart analyze` on Dart files
- **Pre Stop**: Run tests and analysis before completing

### Skills

- `/self-review`: Multi-model code review
- `/inspect-widget`: Interactive widget inspection
- `/start-development`: Full development workflow

## Best Practices

1. **Don't skip phases** - Each phase serves a purpose
2. **Include testing in plans** - Never end plans at implementation
3. **Use hierarchy over screenshots** - More efficient state verification
4. **Keep commits atomic** - One feature/fix per commit
5. **Self-review before completion** - Catch issues early
