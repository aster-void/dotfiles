# Documentation

- Comment intentions and rationales.
- Comment footguns.
  - Examples include:
    - Inclusive/exclusive (off-by-one)
    - Mutation side effects

# Coding Style

- Abort on error, do not skip errors.
  - Decide what counts as an error and what doesn't.
- Use Prefix notation (also known as Hungarian notation) if different variables mean different things but have the same type.
  - such as:
    - x / y / width / height
    - kilometer / yard
    - pixel / cells
- variables names should be descriptive yet concise.
- Split long functions into small functions in same file. ~50 lines is upper limit.
- Separate logic parts with whitespace. this includes functions, class methods and object declarations.

## Code Organization

- Use feature-based directory structure.
  - most things should be in `src/features/{feature}`.
    - this directory may contain `components/`, `func/`, `config/`, `hooks/` etc.
  - `src/lib` should only contain shared utilities.

## Svelte function names

- use `useXXX` if the function needs to be called at component initialization. this is my personal preference.

# Suggestion

- Don't suggest formatting changes.

# Toolchain

- Use bun and TypeScript.
- Use Tailwind and DaisyUI instead of plain CSS.
- Use Svelte 5 (not svelte 4).
  - this means,
    - no implicit reactive variables. use `$state`.
    - no `$:` for derived variables. use `$derived` instead.
    - no `$:` for effects. use `$effect` instead.
    - no `export let`. use `$props()` and `type Props` instead.
    - no `on:{event}`. use `on{event}` instead.
