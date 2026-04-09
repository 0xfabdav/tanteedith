# CoffeeBoxx (Astro + Supabase)

Minimal Astro site with:

- public page fetching settings from Supabase
- admin login (`/admin/login`) with Supabase email/password
- admin settings UI (`/admin`) for one-row `settings` table
- Cloudflare Pages deployment via Astro Cloudflare adapter

## 1) Supabase setup

1. Create a new Supabase project.
2. In Supabase SQL editor, run `docs/supabase.sql`.
3. In Supabase Auth -> Users, create an admin user (email + password).
4. In Supabase Project Settings -> API, copy:
   - Project URL
   - anon public key

## 2) Environment variables

Create `.env` from `.env.example`:

```env
PUBLIC_SUPABASE_URL=your_project_url
PUBLIC_SUPABASE_ANON_KEY=your_anon_key
```

## 3) Run locally

```bash
npm install
npm run dev
```

Routes:

- `/`
- `/admin/login`
- `/admin`
- `/dsvgo`
- `/impressum`

## 4) Deploy to Cloudflare Pages

1. Push repo to GitHub.
2. In Cloudflare Pages, create project from repo.
3. Build settings:
   - Build command: `npm run build`
   - Output directory: `dist`
4. Add env vars in Cloudflare Pages:
   - `PUBLIC_SUPABASE_URL`
   - `PUBLIC_SUPABASE_ANON_KEY`
5. Deploy.

If Cloudflare build logs mention a missing `SESSION` binding, add a KV binding named `SESSION` in your Cloudflare project settings.
