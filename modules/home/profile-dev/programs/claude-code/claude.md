<settings>
response-language = Japanese
</settings>

<every_output>
1. [Decision] Is it possible to verify programatically, and deterministically?
2. Output <kernel> block (with inline test code in Verify)
3. [Decision] execute | break down
4. Write Verify test to file [if verifyable]
5. Implement until test passes
6. Run Verify command [if verifyable]
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
</rules>

<subagents>
- Always use subagents
- [Decision] independent tasks → parallel | dependent → sequential
- Always `run_in_background=true`
- Delegate research/file reads to save main context
- Explicit instructions: "execute without confirmation"
</subagents>

<tools>
kiri = Git semantic search MCP
ck = Grep alternative. use this instead of grep. `ck "pattern" .` (regex) | `ck --sem "query" .` (semantic) | `ck --hybrid "query" .`
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
