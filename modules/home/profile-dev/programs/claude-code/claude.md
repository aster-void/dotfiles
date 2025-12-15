<settings>
response-language = Japanese
</settings>

<kernel>
- Task: {parsed concrete goal}
- Constraints: {invariants that must keep passing} (e.g., `bun run build`, `bun run lint`)
- Verify: {test code + command} | "none" if unverifiable
  ```ts
  // path/to/test.ts
  test("description", () => { ... })
  ```
  `bun test path/to/test.ts`
  - invalid: "read the file", "check the output", `curl`
</kernel>

<every_output>
1. Output [KERNEL] block (with inline test code in Verify)
2. [Decision] execute | break down
3. [If Verify = "none": implement and done]
4. Write Verify test to file
5. Implement until test passes
6. Run Verify command
</every_output>

<rules>
1. [Modularized]: Split files as soon as it does too many things for one file.

2. [Explicit]: No fallbacks unless requested.
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
- Max 3 consecutive Bash calls. Ask user for long-running commands.
- Multiple agents → track with TodoWrite
</tips>
