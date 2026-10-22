<div align="center">

# `<NO/>` Gnonhoua N'golo Ouattara — Portfolio

Portfolio bilingue (FR/EN) de développeur Full Stack Web & Mobile, avec un dashboard pour gérer
projets, parcours, sections et articles sans redéployer.

[![CI](https://github.com/VOTRE_PSEUDO_GITHUB/portfolio/actions/workflows/ci.yml/badge.svg)](https://github.com/VOTRE_PSEUDO_GITHUB/portfolio/actions/workflows/ci.yml)
![Next.js](https://img.shields.io/badge/Next.js-App_Router-000?logo=nextdotjs)
![Supabase](https://img.shields.io/badge/Supabase-Postgres_·_Auth_·_Storage-3ECF8E?logo=supabase&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-strict-3178C6?logo=typescript&logoColor=white)

[Site en ligne](https://VOTRE_DOMAINE) · [Use cases](docs/use-cases.md) · [Architecture](docs/architecture.md)

</div>

## Fonctionnalités

**Site public**
- Projets filtrables par catégorie, carrousel, pop-up de détail partageable (`?projet=slug`)
- Expérience et formation présentées comme un `git log`, en carrousel
- Roadmap, compétences, blog et actualités, contact direct (e-mail, LinkedIn, WhatsApp)
- Français / anglais, responsive, accessible au clavier

**Dashboard**
- Profil et contacts, projets (brouillon/publication, captures), parcours
- Sections du site : afficher, masquer, réordonner, ajouter
- Rédaction d'articles en Markdown, FR/EN

## Stack
Next.js (App Router) · TypeScript · Tailwind CSS · next-intl · Supabase (Postgres + RLS, Auth, Storage) ·
Zod · Vitest · Playwright · GitHub Actions · Vercel

## Démarrer

```bash
git clone https://github.com/VOTRE_PSEUDO_GITHUB/portfolio.git
cd portfolio
cp .env.example .env.local      # renseigner les clés Supabase
npm install
npm run dev
```

Base de données : `npx supabase link --project-ref <ref>` puis `npx supabase db push`.

## Scripts
| Commande | Rôle |
| --- | --- |
| `npm run dev` | serveur de développement |
| `npm run lint` / `typecheck` | qualité |
| `npm run test` / `test:e2e` | tests unitaires / bout en bout |
| `npm run build` | build de production |
| `npm run db:types` | régénère les types Supabase |

## Structure
Voir [docs/architecture.md](docs/architecture.md).

## Licence
[MIT](LICENSE)
