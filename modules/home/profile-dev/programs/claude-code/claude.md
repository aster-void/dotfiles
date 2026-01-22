<terminology>
"docs" = README.md or /docs/ directory (user-facing documentation)
CLAUDE.md = AI instructions (not "docs")
</terminology>

<rules>
[Expression]: Single expression over incremental accumulation.
   - `items.filter(...).map(...)` not `let result = []; for (...) result.push(...)`
   - `a || b` not `let x = a; if (!x) x = b;`
   - `condition ? a : b` not `let x; if (condition) x = a; else x = b;`
   - Transitions (mutation) are for side effects only, keep separate from calculations.

[Deletable]: Optimize for deletion, not extension.
   - Minimize dependencies and coupling
   - Code that's easy to delete is easy to replace
</rules>

<when-stuck>
**When stuck, STOP and follow this checklist:**

1. **Read the library's documentation** - Most issues come from misunderstanding the API
2. **Search GitHub issues** (library repo) - Someone likely faced the same problem
3. **Read error message more carefully** - Often contains the solution
4. **Ask the user** - They may have context you don't

**NEVER give up by using workarounds or hacks.**
</when-stuck>
