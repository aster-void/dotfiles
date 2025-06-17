# Windsurf rules

## General

## Coding Style

- Prefer simple solutions.
- Prefer self-explanatory code.
- Prefer short and self-explanatory variable names.
- Make wrong code look wrong. you may add prefixes or suffixes to variables if that makes wrong things more clear. (e.g. `distance_km` `kg_weight`)
- Prefer short-lived variables.
- Prefer short functions.
- TypeScript: Always add extensions to imports: `import "./foo.ts"`, not `import "./foo"`.

### Codebase structure

- Large file is bad file. Split logic into multiple files as soon as possible.
- Prefer flat directory structure until it's no longer managable (~15 files).

## Documentation

- Don't overuse comments.
- Use comments to explain the intent, not the implementation.
- Comment only the documentation.
- Use types for type-checkable documentation.

## Cascade Session

- If I don't explicitly review your changes, it means the diff was good.

## Commit Message

- Prefix commit message, e.g. `fix:`, `feat:`, `chore:`, `breaking:`.
- Commit message should describe what has become possible after the commit, rather than describint what has changed in detail.
- Commit message should only contain one line. Avoid commit body.

