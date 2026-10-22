---
name: supabase-data
description: Conventions d'accès aux données Supabase (schéma, RLS, clients, Server Actions, Storage, types). À utiliser dès qu'on lit ou écrit des données, crée une migration, gère l'authentification admin ou l'upload d'images.
paths:
  - "src/lib/**"
  - "supabase/**"
  - "src/app/**/actions.ts"
---

# Données Supabase

## Schéma
- La source de vérité est `supabase/migrations/`. Lis la migration `*_init.sql` (et les suivantes) avant toute requête.
- Tables : `profile` (ligne unique id=1), `projects`, `project_images`, `timeline_entries`
  (`kind` = experience | education), `skills_groups`, `roadmap_items`, `site_sections`, `posts`, `admins`.
- Champs traduits : `jsonb` de forme `{"fr": "...", "en": "..."}` (ou `{"fr": [...], "en": [...]}`
  pour les listes). Type TS : `I18nText` / `I18nList` dans `src/lib/i18n-content.ts`.
- Changer le schéma : `npx supabase migration new <nom>`, écrire le SQL, appliquer en local, puis
  `npm run db:types`. Ne modifie jamais une migration déjà poussée.

## Clients
- `src/lib/supabase/server.ts` : `createServerClient` de `@supabase/ssr` avec les cookies de Next
  (Server Components, Server Actions, Route Handlers).
- `src/lib/supabase/client.ts` : `createBrowserClient`, uniquement pour l'authentification côté client.
- Utilise toujours le type généré `Database` : `createServerClient<Database>(…)`.
- **Interdit** : `SUPABASE_SERVICE_ROLE_KEY` dans du code importé côté client. Si un script en a
  besoin (seed), il vit dans `scripts/` et lit la variable d'environnement.

## Lecture (site public)
- Une fonction par besoin dans `src/lib/data/` : `getProfile()`, `getPublishedProjects()`,
  `getProjectBySlug(slug)`, `getTimeline(kind)`, `getEnabledSections()`, `getPublishedPosts()`…
- Filtrer explicitement `status = 'published'` / `enabled = true` même si la RLS le fait déjà.
- Trier par `sort_order` puis date. Mettre en cache avec `revalidate` ou des tags (`projects`, `posts`…).

## Écriture (dashboard)
- Server Actions dans `src/lib/actions/<entite>.ts`, chacune :
  1. vérifie la session et `is_admin()` (helper `requireAdmin()`),
  2. valide l'entrée avec le schéma Zod de `src/lib/validation/`,
  3. écrit via le client serveur,
  4. appelle `revalidatePath('/[locale]', 'layout')` ou `revalidateTag(...)`,
  5. renvoie `{ ok: true } | { ok: false, error }` (pas d'exception non gérée vers l'UI).
- Les toasts « ✓ Projet publié sur le site » de la maquette s'affichent à partir de ce retour.

## Auth admin
- Connexion e-mail + mot de passe (ou lien magique) sur `/[locale]/admin/login`.
- Protection des routes `/admin` dans le middleware de Next (fichier `middleware.ts`, ou `proxy.ts`
  selon la version de Next : vérifie la doc de la version installée), qui rafraîchit la session Supabase.
- Un utilisateur est admin s'il est présent dans la table `admins`.

## Storage
- Bucket public `media` : `projects/<slug>/<n>.webp`, `posts/<slug>/cover.webp`, `profile/photo.webp`, `cv/cv.pdf`.
- Upload uniquement par un admin (policy), affichage via `next/image` avec le domaine Supabase autorisé.
