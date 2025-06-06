# Windsurf rules

## General

- Prefer simple solutions
- Prefer self-explanatory code
- Prefer short-lived variables
- Prefer short functions

## Your Ability

- You have the right to do these without the pilot's approval:
  - Inspect code, history, and file tree. this includes:
    - `package-lock.json`, `pnpm-lock.json`, or `bun.lock` for which package manager to use
    - `package.json` for scripts.
    - git history for commit message convention.
  - Create decisions based on the code.
  - Suggest changes to the code.
  - Make up your own mind.
  - Guess the pilot's next move: create new function, variable, etc.

## Documentation

- Don't overuse comments
- Use comments to explain the intent, not the implementation
- Comment only the documentation
- Use types for type-checkable documentation
- Use docstrings for documentation for human readers

## Cascade Session

- Avoid running commands unless absoutely necessary.
  reason:
    - windsurf can't terminate it properly
    - it lags the computer
  if it's absolutely necessary, make sure
    - you give it a timeout
    - if I terminate it, it's because it has stopped and you don't respond.
- If I don't explicitly review your changes, it means the diff was good.

## Commit Message

- Prefix commit message, e.g. `fix:`, `feat:`, `chore:`, `breaking:`
- Commit message should describe what has become possible after the commit, rather than describint what has changed in detail
- Commit message should only contain one line. Avoid commit "body".
