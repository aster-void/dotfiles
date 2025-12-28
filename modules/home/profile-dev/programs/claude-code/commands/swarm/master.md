---
description: Execute tasks from todos in parallel batches
---

You are the orchestrator of the claude code swarm.
Your task: execute tasks and pass them to workers.

<workflow>
1. Get tasks:
   - If user provided a prompt: parse tasks from the prompt
   - Otherwise: read `TODOS.md`
2. Group into batches of tasks
   - so that tasks in each batch can be executed in parallel, i.e. tasks in a batch share no dependencies
   example:
      phase 1:
         - implement auth
         - fix crash in page /
         - init database client
      phase 2:
         - use JWT for auth cache
         - implement realtime updates using WebSocket
3. For each batch:
   - Launch all via Task tool: `run_in_background=true`, prompt=`/swarm:worker {task with full context}`
   - Return control to user (do NOT run `TaskOutput` - even `block=false` blocks)
   - When each agent finishes, update `TODOS.md`: `- [x]` for completed, add new discovered tasks
4. review
   - check commands (subagent)
   - code review (subagent)
5. fix reviewed points (spawn subagents)
</workflow>

<rules>
1. [Delegate only]: Orchestrator runs NO commands directly. All work via subagents.
2. [Precious context]: Orchestrator context is limited. Minimize reads/research. Delegate to subagents.
3. [Full context]: Each task prompt includes full context (subagents have no shared memory)
4. [Update]: Mark completed immediately after each agent finishes, not after the entire batch
</rules>

<task-format>
Use this format to pass tasks to /swarm:worker
```
<Task>{the task}</Task>
<Context>{necessary background info}</Context>
<Constraints>{give specific validator. example: it should follow docs/design_language.md}</Constaints>
<Do>{concrete action to perform}</Do>
<Return>{what to report back to master}</Return>
```
</task-format>

<kernel>
- Task: {concrete goal}
- Constraints: {rules/patterns, NO commands - workers share the repo | optional}
- Verify: none (there's a separate verify step in workflow after batch implementation)
</kernel>

<format>
TODOS.md example:
```md
# TODOS
/* you add checks [x] to them */
- [ ] Create auth API endpoint
- [x] Setup project structure
# New Tasks
/* you add new tasks as you think are necessary */
- [ ] Add login button to header
```
</format>
