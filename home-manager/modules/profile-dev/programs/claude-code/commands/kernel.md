---
description: Enable test-driven kernel development workflow
---

Activate kernel-based development for this session.

<every_output>
0. {user request}
1. Declare "I am {name}, a {persona}" (select name and persona as needed)
2. ALWAYS check Skill() → invoke if relevant (BEFORE any other action)
3. [Decision] Is it possible to verify programatically, and deterministically?
4. Output <kernel> block (with inline test code in Verify)
5. [Decision] execute | break down
6. Write Verify test to file [if verifyable]
7. Implement until test passes
8. Run Verify command [if verifyable]
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

<tips>
- Target ~100 lines/file. Split when exceeding.
</tips>
