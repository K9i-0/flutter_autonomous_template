# Requirements Template

Use this template when manually creating requirements, or as reference for the generated `REQUIREMENTS.md`.

---

# Project Requirements

## Overview

### App Name
[Name of the application]

### Purpose
[Main purpose and value proposition of the app]

### Target Users
- Primary: [Who will use this app most]
- Secondary: [Other potential users]

### Platforms
- [ ] iOS
- [ ] Android
- [ ] Web

---

## Features

### Core Features

List the main features (3-5 recommended):

1. **Feature Name**
   - Description: [What it does]
   - Priority: High/Medium/Low
   - MVP: Yes/No

2. **Feature Name**
   - Description: [What it does]
   - Priority: High/Medium/Low
   - MVP: Yes/No

3. **Feature Name**
   - Description: [What it does]
   - Priority: High/Medium/Low
   - MVP: Yes/No

### MVP Scope

What must be included in the first release:
- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3

### Future Features (Post-MVP)
- Feature A
- Feature B

---

## Data & Storage

### Data Storage Method
- [ ] Local only (offline first)
- [ ] Cloud/Server (Firebase, Supabase, etc.)
- [ ] Hybrid (local + cloud sync)
- [ ] No persistent storage

### Data Models

List main data entities:

1. **Entity Name**
   - field1: type
   - field2: type
   - Relationships: [related entities]

2. **Entity Name**
   - field1: type
   - field2: type

### Offline Support
- [ ] Not needed
- [ ] Basic offline viewing
- [ ] Full offline with sync
- [ ] Offline-first architecture

---

## Screens & Navigation

### Expected Screens

1. **Screen Name**
   - Purpose: [What user does here]
   - Key elements: [Main UI components]

2. **Screen Name**
   - Purpose: [What user does here]
   - Key elements: [Main UI components]

### Navigation Pattern
- [ ] Bottom navigation bar
- [ ] Drawer/Side menu
- [ ] Tab bar at top
- [ ] Simple stack navigation

### Screen Flow

```
Home → List → Detail
         ↓
       Create/Edit
```

---

## Technical Requirements

### Authentication
- [ ] No authentication needed
- [ ] Email/Password
- [ ] Social login (Google, Apple, etc.)
- [ ] Phone number/OTP
- [ ] Biometric

### External Integrations
- [ ] No external APIs
- [ ] REST APIs: [list endpoints/services]
- [ ] GraphQL: [endpoint]
- [ ] Third-party services: [list services]

### Performance Requirements
- [ ] Standard
- [ ] Fast loading (<2s)
- [ ] Real-time updates
- [ ] Large data handling

### Security Requirements
- [ ] Basic (standard practices)
- [ ] Enhanced (encryption, secure storage)
- [ ] Compliance required (GDPR, HIPAA, etc.)

---

## Design Requirements

### Theme
- [ ] Light only
- [ ] Dark only
- [ ] Both (system preference)

### Branding
- Primary color: [color code]
- Secondary color: [color code]
- Font: [font name or system default]

### Accessibility
- [ ] Standard
- [ ] Enhanced (screen reader support, etc.)

---

## Constraints & Assumptions

### Constraints
- [Any technical or business constraints]

### Assumptions
- [Assumptions made during requirements gathering]

### Dependencies
- [External dependencies or prerequisites]

---

## Success Criteria

How do we know the app is successful?

1. [Criteria 1]
2. [Criteria 2]
3. [Criteria 3]

---

## Next Steps

1. [ ] Review and approve this requirements document
2. [ ] Enter Plan Mode to design implementation
3. [ ] Begin feature-by-feature development

---

*Generated on: [Date]*
*Last updated: [Date]*
