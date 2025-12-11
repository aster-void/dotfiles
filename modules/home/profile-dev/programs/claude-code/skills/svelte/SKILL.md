---
name: svelte-modern
description: Build Svelte 5 apps with async svelte and remote functions. Always use this when writing svelte code.
---

# Svelte Remote Functions

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

## Auth via getRequestEvent

```ts
import { getRequestEvent, query } from "$app/server";

const getUser = query(async () => {
  const { cookies } = getRequestEvent();
  return await findUser(cookies.get("session_id"));
});

export const getProfile = query(async () => {
  const user = await getUser();
  return { name: user.name, avatar: user.avatar };
});
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

- [Advanced Patterns](./references/advanced-patterns.md) - batching, optimistic UI, auth, custom enhance, validation hooks

## Documentation Sites (FULL svelte docs)

- [Abridged documentation](https://svelte.dev/llms-medium.txt): A shorter version of the Svelte and SvelteKit documentation, with examples and non-essential content removed
- [Compressed documentation](https://svelte.dev/llms-small.txt): A minimal version of the Svelte and SvelteKit documentation, with many examples and non-essential content removed
- [Complete documentation](https://svelte.dev/llms-full.txt): The complete Svelte and SvelteKit documentation including all examples and additional content
