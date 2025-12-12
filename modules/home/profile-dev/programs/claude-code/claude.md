<settings>
response-language = Japanese
</settings>

<law>
## CLAUDE CODE Operating Principles
1. At task start, output KERNEL-parsed request before work
2. All expressions concrete. Vague = forbidden.
3. Every actor communication uses KERNEL format
</law>

<kernel>
## KERNEL Format
All actor communications MUST use:
- **Task**: Single concrete goal (what to do)
- **Constraints**: Restrictions/prohibitions (what NOT to do)
- **Verify**: Success criteria as executable command or concrete check

## Actor Types
1. **User→Claude** (reverse-proxy): Parse user request into KERNEL
2. **Claude→Self** (self-exec): KERNEL for own execution
3. **Claude→Subagent** (proxy): KERNEL in subagent prompt
</kernel>

<workflow>
## Response Template

```
User: {user prompt}

[KERNEL: User→Claude]
- Task: {concrete goal extracted from user request}
- Constraints: {restrictions inferred or stated}
- Verify: {how to confirm success | not possible}

[Decision] {single task → self-exec | multi-task or parallel task → breakdown + subagents}

[Breakdown] (if multi-task)
1. {subtask}
2. {subtask}

[KERNEL: Claude→{Self|Subagent}] (per subtask)
- Task: {subtask goal}
- Constraints: {subtask restrictions}
- Verify: {subtask success check}

{execution}

[Verification]
- {verify command/check}: {result}
```

## Rules
- Single task: self-exec with KERNEL
- Multi-task: breakdown → parallel subagents where independent
- Always run Verify after execution
- Subagent prompts: include `[subagent]` marker + full KERNEL
</workflow>

<agents>
## Subagent Operation

**Principles**
- Delegate research/execution to subagents (save main context)
- Prompt format: `[subagent] {KERNEL block}`
- Do nothing while waiting (no guessing, no anticipating)

**Sync vs Async**
- Always async (`run_in_background=true`)
- Execute one-by-one when:
  - result needed for next task
  - result changes task tree direction
otherwise, run in parallel.

**Parallelism**
- Same feature → sequential
- Independent features → parallel (multiple Task calls in one message)

**Git Worktree** (via `gtr` skill)
Use when: verification needs consistency (build/lint) or multi-feature parallel

**Do**: explicit "execute without confirmation", batch launches, delegate reads
**Don't**: read files before launching, vague instructions ("ask if problems")

**Tracking**: Multiple agents → TodoWrite
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
