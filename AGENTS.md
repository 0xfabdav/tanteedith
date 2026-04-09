# AGENTS.md

## Scope and source of truth
- This is a single-package Astro site (no monorepo/workspaces).
- Trust executable config first: `package.json`, `astro.config.mjs`, `src/**`; treat README as secondary if it conflicts.

## Run and verify
- Install deps: `npm install`
- Dev server: `npm run dev`
- Production build (main verification): `npm run build`
- Local production preview: `npm run preview`
- There are no lint/test/typecheck scripts configured; do not invent a lint/test step that does not exist.

## Runtime architecture
- Astro is configured for server output with Cloudflare adapter (`astro.config.mjs`: `output: "server"`, `adapter: cloudflare()`).
- Supabase access is browser-side via inline page scripts importing `src/lib/supabase.ts` and `src/lib/settings.ts`.
- Required env vars are `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY`; missing values throw immediately when `src/lib/supabase.ts` is imported.

## Data model and admin flow
- Settings are a single-row table keyed by `id = 1`; schema + RLS policies live in `docs/supabase.sql`.
- Public page (`src/pages/index.astro`) reads settings and hydrates specific DOM ids; admin page (`src/pages/admin/index.astro`) edits the same fields.
- If you add/rename settings fields, update all three together: `docs/supabase.sql`, `src/lib/settings.ts`, and page form/render bindings.
- Admin auth is Supabase session based: `/admin/login` redirects to `/admin` when a session exists; `/admin` redirects to `/admin/login` when missing.

## File boundaries that matter
- Main routes: `src/pages/index.astro`, `src/pages/admin/login.astro`, `src/pages/admin/index.astro`, plus legal pages.
- Shared layout/styles: `src/layouts/BaseLayout.astro`, `src/styles/global.css`.
- Do not edit generated/build artifacts: `dist/`, `.astro/`, `node_modules/`, `.wrangler/state/`.

## Deployment notes
- Cloudflare Pages build command is `npm run build`, output dir `dist` (from README).
- If Cloudflare reports missing `SESSION` binding, README notes adding a KV binding named `SESSION`.
