# Start Development

Workflow for starting new app/feature development with systematic requirements gathering.

## Overview

This command initiates the autonomous development workflow:
1. Requirements gathering through AskUserQuestion
2. Generation of REQUIREMENTS.md
3. Transition to Plan Mode for implementation design

## Procedure

### Step 1: Invoke Requirements Gathering

Use the `requirements-gathering` skill to systematically collect app specifications through AskUserQuestion.

Key areas to cover:
- App purpose and target users
- Platform targets (iOS/Android/Web)
- Core features and MVP scope
- Data storage strategy
- Screen count and navigation pattern
- Authentication requirements
- External API integrations
- Offline support needs

### Step 2: Generate REQUIREMENTS.md

After gathering all requirements, generate a `REQUIREMENTS.md` file in the project root containing:

```markdown
# Project Requirements

## Overview
- App Name
- Purpose
- Target Users
- Platforms

## Features
### Core Features
[List of main features]

### MVP Scope
[What's essential for first release]

## Data & Storage
- Storage method
- Offline support level

## Screens & Navigation
- Expected screen count
- Navigation pattern

## Technical Requirements
### Authentication
[Auth requirements]

### External Integrations
[API integrations]

## Next Steps
1. Review requirements
2. Enter Plan Mode
3. Begin implementation

---
Generated on: [Date]
```

### Step 3: User Confirmation

Show the requirements summary and ask for confirmation:

```
"I've compiled the requirements. Please review:

[Summary of key points]

Does this look correct? Should we proceed to planning?"
```

### Step 4: Transition to Plan Mode

Once confirmed:
1. Enter Plan Mode with `EnterPlanMode`
2. Design implementation based on REQUIREMENTS.md
3. Break down into features and tasks
4. Create detailed implementation plan

### Step 5: Begin Implementation

After plan approval:
1. Use `TodoWrite` to track tasks
2. Implement feature by feature
3. E2E test each feature with Maestro/Dart MCP
4. Self-review before marking complete
5. Commit using Conventional Commits

## Integration Points

### Skills Used
- `requirements-gathering` - Systematic requirement collection
- `flutter-ui-design` - UI implementation guidelines
- `flutter-mobile-automation` - E2E testing workflow
- `self-review` - Quality assurance before completion

### MCP Tools
- Dart MCP - App launch, hot reload, debugging
- Maestro MCP - UI testing and verification

## Example Usage

User: `/start-development`

Claude:
1. "Let's start by gathering requirements for your app."
2. [Asks series of AskUserQuestion prompts]
3. "Here's the requirements summary..."
4. [User confirms]
5. "Now let's plan the implementation..."
6. [Enters Plan Mode]
7. [Creates detailed plan]
8. [User approves plan]
9. "Starting implementation. First task: [task]"

## Notes

- Don't skip requirements gathering - clear specifications prevent rework
- Allow users to modify requirements at any point
- Keep MVP scope minimal for faster iterations
- Consider offline-first architecture for better UX
