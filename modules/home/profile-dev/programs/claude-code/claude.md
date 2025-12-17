<settings>
response-language = Japanese
</settings>

<every_output>
0. {user request}
1. ALWAYS check Skill() → invoke if relevant (BEFORE any other action)
2. [Decision] Is it possible to verify programatically, and deterministically?
3. Output <kernel> block (with inline test code in Verify)
4. [Decision] execute | break down
5. Write Verify test to file [if verifyable]
6. Implement until test passes
7. Run Verify command [if verifyable]
</every_output>

<kernel>
- Task: {parsed concrete goal}
- Constraints: {invariants that must keep passing} (e.g., `bun run build`, `bun test`)
- Verify: {test code + command} | "none"
  ```ts
  // path/to/test.ts
  test("description", () => { ... })
  ```
  `bun test`
  - invalid: "read the file", "check the output", `curl`
</kernel>

<rules>
1. [Modularized]: Split files as soon as it does too many things for one file.

2. [Explicit]: No fallbacks unless necessary.
   - `rm file.txt` not `rm file.txt || true`
   - `pkgs.hello` not `pkgs.hello or null`

3. [Concrete]: All expressions specific and verifiable.
   - "Add login button to header" not "improve the UI"

4. [Batch]: Group operations. Multiple tool calls in one message.

5. [Minimal]: Remove non-relevant edits before completing. Only keep changes directly related to the task.
</rules>

<subagents>
- Always use subagents
- [Decision] independent tasks → parallel | dependent → sequential
- Always `run_in_background=true`
- Delegate research/file reads to save main context
- Explicit instructions: "execute without confirmation"
- Never wait for subagents. Terminate output instead.
</subagents>

<tools>
kiri = Git semantic search MCP
ck = Grep alternative (use instead of grep/rg)
  Modes: `ck "pattern" .` (regex) | `ck --sem "query" .` (semantic) | `ck --lex "query"` (BM25) | `ck --hybrid "query" .`
  Options: -i (ignore-case) -w (word) -F (fixed-string) -C/-A/-B (context) -l (files-only) --topk N --threshold SCORE --scores
  Note: --type unsupported (use --exclude or .ckignore)
pipe = `set -o pipefail && cmd1 | cmd2`
git-stash = forbidden
git-worktree = Use `gtr` skill for parallel features or consistent verification
</tools>

<commits>
Format: `{scope}: {description}`
Scope: `flake` | `hosts/{name}` | `modules/{name}` | `packages` | `treewide` | `meta`
Example: `modules/git: add commit hooks`
</commits>

<tips>
- Target ~100 lines/file. Split when exceeding.
</tips>

<when-stuck>
**When stuck, STOP and follow this checklist:**

1. **Read the library's documentation** - Most issues come from misunderstanding the API
2. **Search GitHub issues** (library repo) - Someone likely faced the same problem
3. **Read error message more carefully** - Often contains the solution
4. **Ask the user** - They may have context you don't

**NEVER give up by using workarounds or hacks.**
</when-stuck>
