# Windsurf rules

## General

- Prefer simple solutions
- Prefer self-explanatory code
- Prefer short-lived variables
- Prefer short functions

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
