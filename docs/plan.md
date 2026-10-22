# Plan sur 2 jours — une PR par ligne

Ordre impératif : chaque PR part de `main` à jour, après le merge de la précédente.
Les durées sont indicatives et incluent la relecture. ✂️ = peut glisser après la mise en ligne si vous êtes en retard.

## Jour 1 — Socle et site public

| # | Branche | Titre de PR | Use cases | Durée |
| --- | --- | --- | --- | --- |
| 1 | `chore/socle` | `chore: socle Next.js, Tailwind, next-intl, qualité et CI` | UC-T1 | 1h30 |
| 2 | `feat/base-supabase` | `feat(db): schéma Supabase, RLS, seed et clients typés` | UC-T2 | 1h |
| 3 | `feat/design-system` | `feat(ui): tokens, primitives et layout du site` | UC-T1, UC-V6 | 1h30 |
| 4 | `feat/uc-v1-profil` | `feat(site): hero, chiffres et à propos` | UC-V1 | 1h30 |
| 5 | `feat/uc-v2-projets` | `feat(projets): grille, filtres par catégorie et carrousel` | UC-V2 | 1h30 |
| 6 | `feat/uc-v3-popup-projet` | `feat(projets): pop-up de détail accessible` | UC-V3 | 1h30 |

**Fin du jour 1** : le site public affiche les vraies données en FR/EN, en local.

## Jour 2 — Bas de page, dashboard, mise en ligne

| # | Branche | Titre de PR | Use cases | Durée |
| --- | --- | --- | --- | --- |
| 7 | `feat/uc-v4-parcours` | `feat(site): parcours en carrousel, roadmap, compétences, contact` | UC-V4, V5, V7 | 1h30 |
| 8 | `feat/uc-a1-auth-dashboard` | `feat(admin): connexion, layout et vue d'ensemble` | UC-A1, A2 | 1h30 |
| 9 | `feat/uc-a3-profil` | `feat(admin): édition du profil et des contacts` | UC-A3 | 45 min |
| 10 | `feat/uc-a4-projets` | `feat(admin): gestion des projets et des captures` | UC-A4 | 2h |
| 11 | `feat/uc-a5-a6-parcours-sections` | `feat(admin): parcours et sections du site` | UC-A5, A6 | 1h30 |
| 12 ✂️ | `feat/uc-a7-blog` | `feat(blog): blog public et rédaction d'articles` | UC-V5 (blog), A7 | 1h30 |
| 13 | `chore/mise-en-ligne` | `chore: SEO, tests e2e et déploiement Vercel` | UC-T3, T4 | 1h |

**Fin du jour 2** : site en ligne, dashboard opérationnel, contenu réel saisi.

## Règle de priorité si vous êtes en retard
1. Site public complet (PR 1 à 7) et en ligne (PR 13) : c'est ce que voient les recruteurs.
2. Dashboard : profil puis projets (PR 8 à 10).
3. Parcours/sections puis blog (PR 11, 12) : le contenu peut être saisi dans Supabase Studio en attendant.
