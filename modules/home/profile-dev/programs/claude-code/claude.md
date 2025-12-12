<law>
## CLAUDE CODE Operating Principles
At task start, always fill and output the template before beginning work.
By outputting this rule each time, rule adherence is guaranteed.
Write all expressions concretely. Vague expressions are forbidden.
</law>
<every_output>
{{Repeat CLAUDE CODE Operating Principles}}

[Task Breakdown]
1. {{SUBTASK_1}}
2. {{SUBTASK_2}}

[KERNEL Application]

{{SUBTASK_1}}
- Task: {{TASK}}
- Constraints: {{CONSTRAINTS}}
- Verify: {{VERIFY}}

{{SUBTASK_2}}
- Task: {{TASK}}
- Constraints: {{CONSTRAINTS}}
- Verify: {{VERIFY}}
</every_output>

<settings>
language = Japanese
charcode = UTF-8
</settings>

<workflow>
Task Execution Flow:
1. Receive task
2. KERNEL structuring - clarify Task/Constraints/Verify
3. Task breakdown - split into smaller goals
4. Agent delegation - create prompts using KERNEL notation, delegate
5. Report to user
</workflow>

<kernel-prompt>
KERNEL Notation

Apply when executing own tasks and creating subagent prompts:
1. KERNEL conversion: Reinterpret instructions as Context/Task/Constraints/Format/Verify structure
   - Task: Single clear goal (**K**eep it simple, **N**arrow scope)
   - Constraints: Restrictions/prohibitions (**E**xplicit constraints)
   - Format: Expected output format (**L**ogical structure)
   - Verify: Verifiable success criteria (**E**asy to verify, **R**eproducible)
     - Write as concrete commands (e.g., `npm test && bun check`)
2. Breakdown judgment: Always split even if it seems like a single goal (research → [feature A impl+verify | feature B impl+verify] → integration verify)
3. Subagents: Specify Task/Constraints/Verify in prompts (eliminate ambiguity)
</kernel-prompt>

<agents>
Subagent Operation
Principles:
- Delegate all research/execution to subagents (save main context)
- Always include `[subagent]` in subagent prompts
- Do nothing while waiting for results (no reading output, guessing, anticipating)

<sync-async>
Default = async (run_in_background=true)
Conditions for sync (only if any are met):
  - Result is input for subsequent task (e.g., design research → implementation)
  - Result changes direction of entire task tree (e.g., feasibility research)
</sync-async>

<parallel>
Parallel execution:
  - Multiple agents touching same feature → run sequentially
  - Independent features → parallel OK
</parallel>

<git-worktree>
Use gtr for separate worktree → merge/delete after completion when:
- Verification requires overall consistency (build, lint, etc.)
- Multi-feature parallel implementation (separate worktree per agent)
Reference: git-gtr skill
</git-worktree>

<do>
  - Explicitly state "execute without confirmation"
  - Launch independent tasks in parallel (multiple Tasks in one message)
  - Delegate file reading/research to agents
  - Use block=true to wait for async completions together
</do>

<dont>
  - Read files yourself before launching agents
  - Vague instructions ("ask if there are problems" → waiting for confirmation)
</dont>

<notes>
Multiple agents → track with TodoWrite
</notes>
</agents>

<skills>
<git-commit>
Commit message format: `{scope}: {message}`
scope: Commit's impact scope. `packages/{package}`, `modules/{module}`, `treewide`, `meta`, etc.
message: Concise, clear commit description
</git-commit>
</skills>

<tools>
kiri = MCP server for Git semantic search
pipe = ALWAYS `set -o pipefail` before pipes (e.g., `set -o pipefail && cat /foo.json | jq .package.version`)
BashOutput = Max 3 consecutive calls. Long-running commands: leave or ask user
git = git stash absolutely forbidden
</tools>

<preferences>
- All implementations minimal. No verbose code/docs/comments. Keep functional/non-functional requirements minimal.
- Fail explicitly. Never swallow errors silently.
  - `rm some-file.txt` > `rm some-file.txt || true`
  - `pkgs.hello` > `if pkgs ? hello then pkgs.hello else null`
- Split files when large. Target ~100 lines. Use own judgment.
- Batch operations. Not one by one (tool calls, agent launches, etc.)
</preferences>

<tips>
- Don't change current directory. (NO `cd`)
- Don't manually specify CWD. Always at repo root, use `.` not full paths
</tips>
