# Architecture

## Vue d'ensemble

```
Navigateur ──► Vercel (Next.js App Router)
                 ├── /[locale]            site public  (Server Components, cache + revalidation)
                 ├── /[locale]/blog       articles
                 └── /[locale]/admin      dashboard    (protégé, Server Actions)
                         │
                         ▼
                 Supabase : Postgres (RLS) · Auth · Storage (bucket media)
```

- Le site public lit uniquement le contenu publié. Les pages sont mises en cache et revalidées
  quand l'admin publie (`revalidatePath` / `revalidateTag` dans les Server Actions).
- Le dashboard écrit via des Server Actions ; la RLS (`is_admin()`) bloque toute écriture non admin.

## Routes

| Route | Contenu | Use case |
| --- | --- | --- |
| `/[locale]` | Page unique : hero, chiffres, à propos, projets, parcours, roadmap, compétences, blog (option), contact | UC-V1…V7 |
| `/[locale]?projet=<slug>` | Même page, pop-up du projet ouverte | UC-V3 |
| `/[locale]/blog`, `/[locale]/blog/[slug]` | Liste et article | UC-V5 |
| `/[locale]/admin/login` | Connexion | UC-A1 |
| `/[locale]/admin` | Vue d'ensemble | UC-A2 |
| `/[locale]/admin/profil` | Profil & contact | UC-A3 |
| `/[locale]/admin/projets`, `…/projets/[id]` | Liste, création/édition | UC-A4 |
| `/[locale]/admin/parcours` | Expériences et formations | UC-A5 |
| `/[locale]/admin/sections` | Sections du site + bibliothèque | UC-A6 |
| `/[locale]/admin/blog`, `…/blog/[id]` | Articles | UC-A7 |

## Arborescence cible

```
src/
├── app/
│   ├── [locale]/
│   │   ├── layout.tsx                 polices, next-intl provider, <html lang>
│   │   ├── (site)/
│   │   │   ├── page.tsx               assemble les sections selon site_sections
│   │   │   └── blog/[slug]/page.tsx
│   │   └── admin/
│   │       ├── login/page.tsx
│   │       └── (dashboard)/
│   │           ├── layout.tsx         sidebar + requireAdmin()
│   │           ├── page.tsx           vue d'ensemble
│   │           ├── profil/page.tsx
│   │           ├── projets/page.tsx · projets/[id]/page.tsx
│   │           ├── parcours/page.tsx
│   │           ├── sections/page.tsx
│   │           └── blog/page.tsx · blog/[id]/page.tsx
│   ├── globals.css                    tokens Tailwind (@theme)
│   ├── sitemap.ts · robots.ts
├── components/
│   ├── ui/        Eyebrow, SectionHeading, Chip, Tag, Card, IconButton, CarouselDots,
│   │              TerminalWindow, CommitTimeline, StatusBadge, LangSwitch, Toast, Dialog
│   ├── site/      SiteNav, Hero, CodeBackdrop, Stats, About, Projects (+ ProjectCard,
│   │              ProjectFilters, ProjectDialog), Timeline, Roadmap, Skills, BlogPreview, Contact, Footer
│   └── admin/     Sidebar, StatCard, ProfileForm, ProjectTable, ProjectForm, ImageUploader,
│                  TimelineEditor, SectionsManager, SectionLibrary, PostTable, PostEditor
├── i18n/          routing.ts, request.ts (next-intl)
├── lib/
│   ├── supabase/  server.ts, client.ts, middleware.ts, database.types.ts (généré)
│   ├── data/      profile.ts, projects.ts, timeline.ts, sections.ts, posts.ts, skills.ts, roadmap.ts
│   ├── actions/   profile.ts, projects.ts, timeline.ts, sections.ts, posts.ts, media.ts
│   ├── validation/ schémas Zod par entité
│   ├── auth.ts    requireAdmin()
│   └── i18n-content.ts  types I18nText/I18nList + pick()
├── messages/      fr.json, en.json
└── middleware.ts  (ou proxy.ts selon la version de Next) : i18n + session Supabase + garde /admin
tests/
├── unit/          Vitest
└── e2e/           Playwright (un fichier par use case visiteur)
```

## Modèle de données

Voir `supabase/migrations/*_init.sql`.

| Table | Rôle | Lecture publique |
| --- | --- | --- |
| `profile` | ligne unique : identité, bio, disponibilité, contacts, chiffres | oui |
| `projects` | projets (catégories, stack, textes FR/EN, liens) | si `published` |
| `project_images` | captures ordonnées (Storage `media`) | si projet publié |
| `timeline_entries` | expériences et formations (`kind`) | si `published` |
| `skills_groups` | groupes de compétences | oui |
| `roadmap_items` | cartes de la roadmap | oui |
| `site_sections` | visibilité et ordre des sections | si `enabled` |
| `posts` | articles, actualités, tutoriels (Markdown FR/EN) | si `published` |
| `admins` | utilisateurs autorisés à écrire | non |

## Composants client (et pourquoi)
`ProjectFilters` + carrousel (état de filtre/page), `ProjectDialog` (pop-up, focus, URL), carrousels de
`Timeline`, `LangSwitch`, formulaires et uploads admin, `Toast`. Tout le reste est rendu côté serveur.

## Variables d'environnement
| Nom | Où | Secret |
| --- | --- | --- |
| `NEXT_PUBLIC_SUPABASE_URL` | Vercel, GitHub Actions, `.env.local` | non |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` (ou clé « publishable ») | idem | non |
| `SUPABASE_SERVICE_ROLE_KEY` | scripts locaux uniquement, jamais dans le code client | **oui** |
| `NEXT_PUBLIC_SITE_URL` | Vercel | non |
