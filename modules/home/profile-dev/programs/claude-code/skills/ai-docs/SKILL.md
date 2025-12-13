---
name: ai-docs
description: ALWAYS use this skill when writing AI documentation. Covers CLAUDE.md, AGENTS.md, system prompts, AI-targeted comments, and architecture docs for AI consumption.
---

# AI Documentation Skill

## Research-Backed Principles (2024-2025)

### What Works

| Technique | Why | Source |
|-----------|-----|--------|
| **XML tags** | Claude trained on XML; improves parsing & structure | Anthropic docs |
| **Templates with `{placeholders}`** | More reliable than prose instructions | Prompt engineering research |
| **Concise + sufficient context** | >3000 tokens degrades reasoning | LLM length studies |
| **Few-shot examples (1-3)** | Biggest gain is 0→1 example; diminishing returns after | Few-shot research |
| **Positive framing** | "Do X" reduces ambiguity vs "Don't do X" | PromptHub studies |
| **Explicit output format** | JSON/list/structure specification improves accuracy | Multiple studies |
| **Task decomposition** | One prompt = one task | Overload research |

### What Doesn't Work

| Anti-Pattern | Problem | Research Finding |
|--------------|---------|------------------|
| **Vague prompts** | Forces AI to guess → generic output | Universal finding |
| **Overloaded prompts** | Multiple tasks = quality degradation | Task complexity studies |
| **Heavy persona prompting** | <10% variance explained for accuracy tasks | ACL 2024: Persona Effect |
| **Long verbose prompts** | Recency bias; vaguer responses | Length impact studies |
| **Negative instruction lists** | "Don't do X" underperforms "Do Y" | PromptHub research |
| **Contradicting instructions** | Common in long system prompts | Best practices guides |

### Claude-Specific

- Claude weighs **user messages > system prompts** (unlike GPT)
- XML tags like `<instructions>`, `<example>`, `<thinking>` are optimal
- Nest tags for hierarchy: `<outer><inner></inner></outer>`
- Be consistent with tag names; reference them in instructions

## Document Template

```markdown
<settings>
key = value
</settings>

<rules>
1. [Rule]: [concrete example]
   - `good example` not `bad example`
</rules>

<workflow>
Template with {fill_in_placeholders}:
- [Decision] {condition} → {action}
</workflow>

<tools>
tool-name = constraint or usage tip
</tools>

<tips>
- [Actionable tip with example]
</tips>
```

## Writing Rules

### Structure Over Prose
```
BAD:  "You should try to keep your commit messages clear and descriptive"
GOOD: Commit: `{scope}: {description}` (e.g., `modules/git: add hooks`)
```

### Positive Over Negative
```
BAD:  "Don't use cd commands"
GOOD: "Stay at repo root. Use relative/absolute paths."
```

### Concrete Over Abstract
```
BAD:  "Keep files reasonably sized"
GOOD: "Target ~100 lines/file. Split when exceeding."
```

### Decision Markers
```
[Decision] simple task → execute | complex task → break down first
[Decision] {condition} → {action A} | {otherwise} → {action B}
```

## Content Guidelines

**Include** (project-specific, non-obvious):
- Conventions: commit format, file naming, directory rules
- Constraints: "never X", "always Y before Z"
- Decision templates with conditions
- Tool-specific gotchas

**Exclude** (AI already knows or can find):
- Generic best practices
- Tool documentation
- Code explanations (AI reads code)
- Tutorials

## Length Guidelines

| Document | Target | If Exceeded |
|----------|--------|-------------|
| CLAUDE.md | 50-150 lines | Split into skills |
| Skills | 50-100 lines | Split into sub-skills |
| Inline comments | 1 line | Rare exceptions for complex WHY |

Reasoning: >3000 tokens measurably degrades LLM reasoning quality.

## Checklist

Before finalizing AI documentation:
1. Using XML tags for structure?
2. Templates have `{placeholder}` syntax?
3. All instructions positive framing?
4. Decision points marked with `[Decision]`?
5. Concrete examples for every rule?
6. Under length limit?
7. No redundant info AI can infer?
