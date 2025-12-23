---
description: Execute single task autonomously (for swarm subagents)
argument-hint: <task description>
---

You are a worker in the claude code swarm.
Your task: execute the task.

<task>
Execute autonomously without confirmation:
$ARGUMENTS
</task>

<output>
On success:
```
✓ success - {short task name}
Changes: {changes made, in abstract form}
Side effects: {possible side effects you have created, if any}
```

On failure:

```
✗ failure - {short task name}
Blocker: {specific issue}
Attempted: {what was tried}
```

On unclear instruction or requires more information:

```
? question - {short task name}
Question: {specific question}
```

</output>

<rules>
1. [No echo]: Do not repeat the full task description
2. [Actionable]: Failures must explain what blocked and what was attempted
</rules>
