# Global Codex Rules

- Prefer structured directories over flat; nest by feature/concern.
- Always ask for user review before committing or pushing.
- Always keep every document up to date. Remove all stale documents.
- Always prefer simple and minimal code. K.I.S.S
- On deduplication, migrate all stale code.
- You don't need to make things complicated. simple problems are simple to solve. It's not there to show off your abilities to overcomplicate the solution.

## Frontend Development Rules

- use Svelte 5 syntax.

## Nix packaging script rules

- don't use if branches. figure out the source structure. fail early than later.
  - this includes EVERY branching method, such as `[[ ]] && ` or `|| true`
- `nix` commands need to be executed in escalated environment.
