---
name: svelte-modern
description: Build async Svelte 5 apps with remote functions. Use when creating components with async data, SvelteKit remote functions, or optimistic UI.
---

# Svelte Modern

## Runes Quick Reference

| Rune | Usage | Purpose |
|------|-------|---------|
| `$state(value)` | `let count = $state(0)` | Reactive state |
| `$derived(expr)` | `const doubled = $derived(count * 2)` | Computed values |
| `$effect(() => {})` | `$effect(() => console.log(count))` | Side effects |
| `$props()` | `let { width, height = 100 } = $props()` | Component props |

## Async Svelte (Experimental)

**Enable in `svelte.config.js`:**
```js
export default {
  kit: {
    experimental: {
      remoteFunctions: true,
    }
  },
  compilerOptions: {
    experimental: { async: true }
  }
};
```

### Direct Await in Components
```svelte
<script>
  let userId = $state(1);
  const user = await fetch(`/api/users/${userId}`).then(r => r.json());
</script>

<p>{user.name}</p>
```

### Await in $derived
```js
const data = $derived(await fetchData(id));
const transformed = $derived(await process(data));
```

### Synchronized Updates
- UI updates ONLY when ALL async work completes
- Prevents inconsistent intermediate states
- Overlapping updates: fast updates show immediately, slow ones continue in background

### Loading & Error States
```svelte
<svelte:boundary>
  {#snippet pending()}
    <div class="spinner">Loading...</div>
  {/snippet}

  {#snippet failed(error)}
    <p>Error: {error.message}</p>
  {/snippet}

  <UserProfile user={await fetchUser(id)} />
</svelte:boundary>
```

### Check Pending State
```js
const isPending = $effect.pending();
// True if any async work is pending in this component
```

### Async Best Practices
1. **Always wrap async with boundaries** - Handle loading/error states
2. **Separate async concerns** - Use multiple boundaries for independent data
3. **Prefer remote functions** - More powerful than plain fetch (see below)
4. **Don't mix sync/async state** - Keep them in separate boundaries

## Remote Functions (SvelteKit)

**Status:** Experimental (v2.27+). Enable in `svelte.config.js` with `kit.experimental.remoteFunctions: true`.

Create in `.remote.ts` files. Four types: `query`, `form`, `command`, `prerender`.

### Query - Read Dynamic Data
```ts
// src/routes/user.remote.ts
import { query } from '$app/server';
import { db } from '$lib/server/db';

// With validation schema
import { number } from '@standard-schema/zod';

export const getUser = query(number(), async (userId) => {
  const user = await db.users.findUnique({ where: { id: userId } });
  if (!user) throw new Error('User not found');
  return user;
});

// Without validation (use sparingly)
export const getSettings = query('unchecked', async () => {
  return await db.settings.findFirst();
});
```

```svelte
<!-- src/routes/+page.svelte -->
<script>
  import { getUser } from './user.remote';

  let userId = $state(1);
  const user = await getUser(userId);
</script>

<p>{user.name}</p>
```

### Form - Progressive Enhancement
```ts
// profile.remote.ts
import { form } from '$app/server';
import { object, string } from '@standard-schema/zod';

const profileSchema = object({
  name: string().min(1),
  email: string().email()
});

export const updateProfile = form(profileSchema, async (data, event) => {
  const userId = event.locals.user.id;
  await db.users.update({
    where: { id: userId },
    data: { name: data.name, email: data.email }
  });
  return { success: true };
});
```

```svelte
<script>
  import { updateProfile } from './profile.remote';
  let user = $state({ name: 'Alice', email: 'alice@example.com' });
</script>

<form {...updateProfile.attrs}>
  <input name="name" bind:value={user.name} />
  <input name="email" bind:value={user.email} />
  <button>Save</button>
</form>
```

### Command - Write Operations
```ts
// analytics.remote.ts
import { command } from '$app/server';
import { string } from '@standard-schema/zod';

export const trackEvent = command(string(), async (eventName, event) => {
  await analytics.track({
    event: eventName,
    userId: event.locals.user?.id,
    timestamp: new Date()
  });
});

// Refresh queries after command
export const deletePost = command(number(), async (postId, event) => {
  await db.posts.delete({ where: { id: postId } });

  // Refresh the posts query on the client
  await getPosts.refresh();
});
```

```svelte
<script>
  import { trackEvent, deletePost } from './analytics.remote';

  async function handleDelete(id) {
    await deletePost(id); // getPosts will auto-refresh
  }
</script>

<button onclick={() => trackEvent('button_clicked')}>
  Click me
</button>
```

### Prerender - Static Generation
```ts
// blog.remote.ts
import { prerender } from '$app/server';
import { number } from '@standard-schema/zod';

export const getPost = prerender(number(), async (postId) => {
  return await db.posts.findUnique({ where: { id: postId } });
}, {
  // Generate pages for these IDs at build time
  entries: async () => {
    const posts = await db.posts.findMany();
    return posts.map(p => p.id);
  }
});
```

### Refreshing Queries
```svelte
<script>
  import { getUser } from './user.remote';

  let userId = $state(1);
  const user = await getUser(userId);

  async function reload() {
    await getUser.refresh(); // Re-fetch from server
  }
</script>

<button onclick={reload}>Refresh</button>
```

### Batching Multiple Queries
```svelte
<script>
  import { getUser, getPosts } from './data.remote';

  // Requests batched into single HTTP call
  const [user, posts] = await Promise.all([
    getUser(1),
    getPosts(1)
  ]);
</script>
```

### Remote Function Best Practices
1. **Use query for reads** - Dynamic data that changes per request
2. **Use form for user mutations** - Progressive enhancement, works without JS
3. **Use command for side effects** - Tracking, notifications, non-form updates
4. **Use prerender for static data** - Build-time generation for blogs, docs
5. **Always validate inputs** - Use Standard Schema (Zod, Valibot, etc.)
6. **Refresh queries after mutations** - Call `.refresh()` to update dependent data
