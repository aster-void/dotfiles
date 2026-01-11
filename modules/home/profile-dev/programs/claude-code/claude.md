<settings>
response-language = Japanese
</settings>

<rules>
1. [Modularized]: Split files as soon as it does too many things for one file.

2. [Explicit]: No fallbacks unless necessary.
   - `rm file.txt` not `rm file.txt || true`
   - `v.parse(v.string(), env.API_URL)` not `env.API_URL || "http://localhost:3000"`

3. [Concrete]: All expressions specific and verifiable.
   - "Add login button to header" not "improve the UI"

4. [Batch]: Group operations. Multiple tool calls in one message.

5. [Minimal]: Remove non-relevant edits before completing. Only keep changes directly related to the task.

6. [Security]: Never read `.env` files. Use `.env.sample` or `.env.example` instead.

7. [Stateless]: Don't introduce state. ANY KIND of state counts. Before adding state, repeat why it's absolutely necessary. This includes:
   - Application-global state
   - State that user has to track
   - Code that needs to change whenever another file changes
</rules>

<subagents>
- Always use subagents
- [Decision] independent tasks → parallel | dependent → sequential
- Always `run_in_background=true`
- Delegate research/file reads to save main context
- Explicit instructions: "execute without confirmation"
- Never wait for subagents. Terminate output instead.
  - Exception: research agents can be awaited when results are needed immediately
</subagents>

<tools>
bash = Use `bash -c "cmd"` wrapper (built-in Bash tool is broken)
ck = Grep alternative (use instead of grep/rg)
  Modes: `ck "pattern" .` (regex) | `ck --sem "query" .` (semantic) | `ck --lex "query"` (BM25) | `ck --hybrid "query" .`
  Options: -i (ignore-case) -w (word) -F (fixed-string) -C/-A/-B (context) -l (files-only) --topk N --threshold SCORE --scores
  Note: --type unsupported (use --exclude or .ckignore)
kiri = Git semantic search MCP
pipe = `set -o pipefail && cmd1 | cmd2`
git-stash = forbidden
git-worktree = Use `gtr` skill for parallel features or consistent verification
git-unstage = `git unstage [file]` - unstage files (safe)
git-uncommit = `git uncommit` - undo last commit, keep changes staged (safe)
git-reset = `git reset HEAD` - ⚠️ DANGER: resets working tree files! Use `git unstage` instead
</tools>

<skills>
**READ THE AVAILABLE SKILLS** in the Skill tool description before starting any task. Use them when relevant.
</skills>

<when-stuck>
**When stuck, STOP and follow this checklist:**

1. **Read the library's documentation** - Most issues come from misunderstanding the API
2. **Search GitHub issues** (library repo) - Someone likely faced the same problem
3. **Read error message more carefully** - Often contains the solution
4. **Ask the user** - They may have context you don't

**NEVER give up by using workarounds or hacks.**
</when-stuck>
