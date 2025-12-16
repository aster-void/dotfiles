---
name: svelte
description: Build Svelte 5 apps with async svelte and remote functions. Always use this when writing svelte code.
---

<rules>
1. [Reactivity]: `$derived` not `$effect` — $effect is escape hatch for external systems (DOM APIs, timers)
2. [Query refresh]: After mutation, call `relatedQuery.refresh()` to invalidate
3. [Single-flight]: Same query + same args = one request (auto-deduplicated)
4. [Auth at DAL]: Every `.remote.ts` validates auth before DB calls
5. [DB layer]: Authorization-unaware, no `getRequestEvent()`
</rules>

## Type-safe Context

```ts
export const [useFoo, setupFoo] = createContext<Foo>();
```

<tips>
- class arrays (built-in clsx): `class={["btn", active && "active", size]}`
- `{@const x = derived}` - template内ローカル定数
- `$bindable()` - 双方向バインディング用props: `let { value = $bindable() } = $props()`
- top-level `await` - `{#snippet pending}` 不要。省略可
- context は `await` より前に呼ぶ必要あり
- `<slot />` は非推奨。`{#snippet}` と `{@render}` を使う:
  ```svelte
  <!-- 親: propsとしてsnippetを渡す -->
  <Card>
    {#snippet header()}<h1>Title</h1>{/snippet}
    {#snippet children()}Content here{/snippet}
  </Card>

  <!-- 子: propsで受け取って@renderで描画 -->
  <script>let { header, children } = $props()</script>
  {@render header()}
  {@render children()}
  ```
</tips>

<layers>
Anywhere → DAL (`$lib/data/*.remote.ts`) → DB (`$lib/server/database/*`)

- `*.remote.ts` - DAL with authorization (`query`/`form`/`command`)
- `*.server.ts`, `$lib/server` - Trusted, server-only execution (includes DB)
</layers>

## Remote Functions

Create in `.remote.ts` files.

### Types

```ts
import * as v from "valibot";
import { query, form, command } from "$app/server";

// QUERY: read data
export const getPost = query(v.string(), async (slug) => {
  return db.posts.findBySlug(slug);
});

// FORM: mutations with progressive enhancement
export const createPost = form(
  v.object({ title: v.string(), content: v.string() }),
  async (data) => {
    await db.posts.create(data);
    await listPosts.refresh();
    redirect(303, "/blog");
  },
);

// COMMAND: mutations that can be called from JS instead of form
export const deletePost = command(v.string(), async (id) => {
  await db.posts.delete(id);
  await listPosts.refresh();
});
```


### Command usage

```ts
await addLike(id);
// or let svelte update other queries after this:
// This is not necessary if `addLike` command runs `await getLikes().refresh()` server-side as above
await addLike(id).updates(getLikes());
```

with optimistic updates:

```ts
await addLike(id)
  .updates(getLikes(id).withOverride((n) => n + 1));
```

### Form Usage

```svelte
<form {...createPost}>
  <input {...createPost.fields.title.as("text")} />
  <input {...createPost.fields.content.as("textarea")} />

  {#each createPost.fields.title.issues() as issue}
    <p class="error">{issue.message}</p>
  {/each}

  <button disabled={!!createPost.pending}>Submit</button>
</form>
```

Field Types:

```svelte
.as("text") .as("number") .as("email") .as("date")
.as("file") .as("checkbox") .as("radio", "value") .as("textarea") .as("select")
```

## References

- [Architecture](./references/architecture.md) - structures, auth helpers
- [Advanced Patterns](./references/advanced-patterns.md) - batching, optimistic UI, advanced form
- [File Uploads](./references/file-uploads.md) - form/command file upload patterns
- [Svelte Docs](https://svelte.dev/llms-medium.txt) - full documentation
