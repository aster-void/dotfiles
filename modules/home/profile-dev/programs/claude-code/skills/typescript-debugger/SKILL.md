---
name: typescript-debugger
description: Debug TypeScript type errors. Use when: (1) Encountering type errors, (2) Refactoring with multiple type errors, (3) Unsure about any/as/as const/type predicates usage. Focuses on dangerous features Claude frequently misuses.
---

# TypeScript Debugger

## Checklist

1. **No `any`** - Use `unknown` and validate with valibot
2. **No `as`** - Fix types at source
4. **No `!`** - Explicit checks instead
5. **NO `value is T`** - Use valibot instead
7. **Discriminated unions** - Add `type` field to narrow

## Good Practices

1. `as const` - For literal types only
2. `value satisfies T` - Type-checks value without changing its type (safe, unlike `is T`)
3. Builtin narrowing - `typeof`, `Array.isArray`, `in`, `instanceof` are always safe
4. `T extends SomeType` if T is required to have some trait
5. `foo?.bar` - Use `?.` for safe property access
6. When refactoring - Fix ONE type error at a time (type inference changes)

## When Stuck - NEVER Give Up

When you're stuck and considering `any` or `as`, STOP:

1. Read error message more carefully
2. Read the library's documentation
3. Search GitHub issues (library repo)
4. Use valibot to validate (if the type is unknown at runtime)
5. Ask the user

**`any` and `as` are admitting defeat.** Always use choose another method.
