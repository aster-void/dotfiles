---
name: ai-docs
description: Write effective documentation for AI assistants. Use when creating/updating CLAUDE.md, writing comments for AI, or documenting architecture decisions.
---

# AI Documentation

Documentation for AI assistants differs fundamentally from human documentation.

## Core Principles

**AI reads code directly** - explain WHY, not WHAT
**Short wins** - context window is shared with code
**Explicit rules** - AI follows exact constraints better than vague principles
**No tutorials** - AI already knows common tools

## What to Include

✅ **Project-specific conventions**
- Commit message format, file naming rules
- Custom patterns unique to this codebase

✅ **Non-obvious decisions**
- "We chose X over Y because..."
- "This weird pattern exists due to Z constraint"

✅ **Constraints and gotchas**
- "Never use git stash" / "Always set -o pipefail with pipes"
- "config/ is auto-generated, edit source/"
- "DB migrations run automatically, don't run manually"

✅ **Domain knowledge**
- Business rules not visible in code
- External system integrations

✅ **Directory structure** (non-standard layouts only)

## What NOT to Include

❌ Generic best practices (AI knows)
❌ Tool documentation (AI can search)
❌ Code explanations (AI reads code)
❌ Implementation details (visible in code)

## Format Guidelines

**Structure over prose**
```
DO:   "- Never use X
       - Always use Y when Z"
DON'T: "It's important to note that X should generally be avoided in most cases..."
```

**Front-load important info**
Put critical rules at the top. Less important context goes below.

**Be explicit**
```
DO:   "Run `npm test` before commit"
DON'T: "Tests should pass"
```

## Creating CLAUDE.md

**Target length**: 50-150 lines. Split into skills if longer.

**Workflow**:
1. Explore project root - understand structure
2. Check package.json, README.md, .github/, build scripts
3. Answer these questions:
   - What's the project's purpose?
   - Any unique directory structure?
   - Any custom rules/conventions?
   - Critical constraints developers must know?
4. Write concisely using template below
5. Place CLAUDE.md in project root

**Template structure**:
```markdown
# Project Name

## Overview
[1-2 sentence project purpose]

## Directory Structure
- `src/` - Application code
- `config/` - Configuration files

## Rules
- **File placement**: [rules]
- **Commits**: [format]

## Development Workflow
```sh
npm run build  # Build
npm test       # Test
```

## Tips
- [Project-specific gotchas]
```

**Decision criteria**:
1. Visible in code? → Don't document
2. In official docs? → Don't document
3. Project-specific rule/knowledge? → Document
4. Critical implicit knowledge? → Document

## Inline Comments

```typescript
// Use WebSocket here (not polling) - HTTP/2 push not supported by proxy
const ws = new WebSocket(url);
```
Comment the WHY (constraint/decision), not the WHAT (obvious from code).

## Anti-Patterns

🚫 "Here's how to use Git" - AI knows Git
🚫 Restating code in prose - wastes context
🚫 Vague guidelines - "try to keep functions small"
🚫 Excessive detail - every parameter documented
🚫 Too long CLAUDE.md - compresses context window

## Quick Checklist

Before writing docs for AI:
1. Is this visible in code? → Don't document
2. Is this common knowledge? → Don't document
3. Is this project-specific? → Document
4. Is this a constraint/gotcha? → Document
5. Can I make it shorter? → Do it
