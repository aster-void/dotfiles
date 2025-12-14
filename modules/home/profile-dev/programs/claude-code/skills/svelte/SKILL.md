---
name: svelte-modern
description: Build Svelte 5 apps with async svelte and remote functions. Always use this when writing svelte code.
---

# Architecture

<layers>
Anywhere → DAL ($lib/data/**/*.remote.ts) → DB ($lib/server/database/*)
- Callers: .svelte, .svelte.ts, +page.ts, +page.server.ts, utilities, etc.
- DAL (Data Access Layer): Authorization + data fetching. Uses `query`/`form`/`command`
- DB Layer: Raw database access. Server-only (`$lib/server/`)
</layers>

## src/lib Structure

### Basic (Innocent)
```
$lib/
├── utils/           # Pure utility functions (no app logic)
├── components/      # Shared UI components
├── data/            # DAL - *.remote.ts files - authorization happens here
├── server/          # Server-only code (or use *.server.ts)
│   └── database/    # DB access layer
└── types/           # Shared types
```

### Route-Colocated
```
routes/
├── blog/
│   ├── +page.svelte
│   ├── +page.ts
│   ├── BlogList.svelte      # route-specific component
│   └── blog-rules.ts        # route-specific logic
lib/
├── components/              # shared components only
├── utils/
├── data/
└── server/database/
```

### DDD (Domain-Driven)
For large apps with clear domain boundaries.
```
$lib/
├── features/        # or "domain/"
│   ├── auth/
│   │   ├── components/
│   │   ├── data.remote.ts
│   │   ├── database.server.ts  # DB access
│   │   └── types.ts
│   └── blog/
│       ├── components/
│       ├── data.remote.ts
│       ├── database.server.ts
│       └── types.ts
└── shared/          # Cross-cutting concerns
    ├── utils/       # App-irrelevant utilities
    └── components/
```

### Conventions
- `*.server.ts` - Server-only (alternative to `$lib/server/`)
- `*.remote.ts` - DAL files with authorization
- Server code assumes authorized context (via DAL)

<rules>
1. Authorization at DAL: Every `.remote.ts` validates authorization before DB calls ("everyone" is also an authorization)
2. DB layer is authorization-unaware: Pure data operations, no `getRequestEvent()`
3. Never import `$lib/server/*` directly except from DAL
</rules>

# DAL Examples

```ts
// $lib/server/auth.ts (helper, not DAL)
export async function getUserFromCookies(cookies: Cookies) {
  const session = cookies.get("session_id");
  if (!session) return null;
  return await db.users.findBySession(session);
}
async function requireUser() {
  const { cookies } = getRequestEvent();
  const user = await getUserFromCookies(cookies);
  if (!user) error(401, "Unauthorized");
  return user;
}

// $lib/data/blog.remote.ts (DAL - auth boundary)
import { getRequestEvent, query, error } from "$app/server";
import { requireUser } from "$lib/server/auth";
import * as db from "$lib/server/database";

// Public: everyone-authorization
export const listPosts = query(async () => {
  return db.posts.listPublished();
});

// Protected: requires user-level authorization
export const getMyDrafts = query(async () => {
  const user = await requireUser();
  return db.posts.findDraftsByAuthor(user.id);
});
```

# Remote Functions

Experimental (v2.27+). Create in `.remote.ts` files.

## Config

```js
// svelte.config.js
export default {
  kit: { experimental: { remoteFunctions: true } },
  compilerOptions: { experimental: { async: true } },
};
```

## Four Types

```ts
// data.remote.ts
import * as v from "valibot";
import { error, redirect } from "@sveltejs/kit";
import { query, form, command, prerender } from "$app/server";
import * as db from "$lib/server/database";

// QUERY: read data
export const getPost = query(v.string(), async (slug) => {
  const [post] = await db.sql`SELECT * FROM post WHERE slug = ${slug}`;
  if (!post) error(404, "Not found");
  return post;
});

// FORM: mutations with progressive enhancement
export const createPost = form(
  v.object({
    title: v.pipe(v.string(), v.nonEmpty()),
    content: v.pipe(v.string(), v.nonEmpty()),
  }),
  async ({ title, content }) => {
    await db.sql`INSERT INTO post (title, content) VALUES (${title}, ${content})`;
    redirect(303, "/blog");
  },
);

// COMMAND: side effects (non-form mutations)
export const addLike = command(v.string(), async (id) => {
  await db.sql`UPDATE item SET likes = likes + 1 WHERE id = ${id}`;
  getLikes(id).refresh(); // refresh related query
});

// PRERENDER: static at build time
export const getPosts = prerender(async () => {
  return await db.sql`SELECT title, slug FROM post`;
});
```

## Component Usage

```svelte
<script>
  import { getPost, createPost } from "./data.remote";
  let { params } = $props();
  const post = $derived(await getPost(params.slug));
</script>

<!-- Async boundary -->
<svelte:boundary>
  {#snippet pending()}<p>Loading...</p>{/snippet}
  {#snippet failed(e)}<p>Error: {e.message}</p>{/snippet}
  <h1>{post.title}</h1>
</svelte:boundary>

<!-- Form with validation -->
<form {...createPost}>
  {#each createPost.fields.title.issues() as issue}
    <p class="error">{issue.message}</p>
  {/each}
  <input {...createPost.fields.title.as("text")} />
  <button>Submit</button>
</form>
```

## Form Field Types

```svelte
<input {...fields.name.as("text")} />
<input {...fields.age.as("number")} />
<input {...fields.photo.as("file")} />
<input {...fields.agree.as("checkbox")} />
<input {...fields.os.as("radio", "linux")} />
```

## References

- [Advanced Patterns](./references/advanced-patterns.md) - ownership authorization, batching, optimistic UI, custom enhance, validation

## Documentation Sites (FULL svelte docs)

- [Abridged documentation](https://svelte.dev/llms-medium.txt): A shorter version of the Svelte and SvelteKit documentation, with examples and non-essential content removed
- [Compressed documentation](https://svelte.dev/llms-small.txt): A minimal version of the Svelte and SvelteKit documentation, with many examples and non-essential content removed
- [Complete documentation](https://svelte.dev/llms-full.txt): The complete Svelte and SvelteKit documentation including all examples and additional content
