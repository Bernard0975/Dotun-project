<div align="center">
<img width="1200" height="475" alt="GHBanner" src="https://github.com/user-attachments/assets/0aa67016-6eaf-458a-adb2-6e31a0763ed6" />
</div>

# Run and deploy your AI Studio app

This contains everything you need to run your app locally.

View your app in AI Studio: https://ai.studio/apps/368c65a0-9438-4000-a421-b39232a60fc2

## Run Locally

**Prerequisites:** Node.js

1. Install dependencies:
   `npm install`
2. Create a `.env` file and set the Supabase environment variables:
   ```env
   VITE_SUPABASE_URL="https://your-project-ref.supabase.co"
   VITE_SUPABASE_ANON_KEY="your_public_anon_key"
   ```
3. Run the app:
   `npm run dev`

## Supabase Setup

This app now stores data in Supabase instead of SQLite.

1. Create a new Supabase project.
2. Go to the SQL editor and run `supabase-schema.sql`.
3. In Supabase settings, copy:
   - `API URL` → `VITE_SUPABASE_URL`
   - `anon key` → `VITE_SUPABASE_ANON_KEY`
4. Make sure email/password auth is enabled.

## Deployment

This project is a static Vite frontend and can be hosted on Vercel, Netlify, or any static hosting service.

1. Push the repository to GitHub.
2. Connect the repo to Vercel or Netlify.
3. Set the same environment variables in the host:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Build command:
   `npm run build`
5. Publish the `dist/` folder.
