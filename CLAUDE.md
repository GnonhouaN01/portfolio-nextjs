# Portfolio — Gnonhoua N'golo Ouattara

Portfolio de développeur Full Stack (site public bilingue FR/EN) + dashboard d'administration
pour mettre à jour le contenu sans toucher au code.

## Stack

- **Next.js** (App Router, TypeScript strict, Server Components par défaut)
- **Supabase** : Postgres + Auth + Storage, accès via `@supabase/ssr`
- **Tailwind CSS** avec les tokens de `docs/design/tokens.md` (aucune couleur hors tokens)
- **next-intl** pour l'interface (FR par défaut, EN), contenu traduit stocké en `jsonb {fr, en}`
- **Zod** pour valider toutes les entrées (formulaires admin, Server Actions)
- **Vitest** (unitaires) + **Playwright** (e2e des use cases)
- Déploiement **Vercel**

## Commandes

```bash
npm run dev          # serveur local http://localhost:3000
npm run lint         # ESLint
npm run typecheck    # tsc --noEmit
npm run test         # Vitest
npm run test:e2e     # Playwright
npm run build        # build de production
npm run db:types     # régénère src/lib/supabase/database.types.ts
```

Avant de déclarer une tâche terminée : `npm run lint && npm run typecheck && npm run test && npm run build`.

## Structure

```
src/
  app/[locale]/(site)/        site public (une page + /blog)
  app/[locale]/admin/         dashboard (protégé)
  components/ui/              primitives (Button, Chip, Card, Eyebrow, Terminal…)
  components/site/            sections du site public
  components/admin/           écrans du dashboard
  lib/supabase/               clients server/browser + types générés
  lib/data/                   lecture des données (une fonction par entité)
  lib/actions/                Server Actions admin (Zod + revalidatePath)
  lib/validation/             schémas Zod
  messages/fr.json, en.json   textes d'interface
supabase/migrations/          SQL versionné (source de vérité du schéma)
docs/                         use cases, architecture, design, plan
```

## Règles non négociables

### Git & GitHub
- **Jamais de commit direct sur `main`.** Une branche par use case : `feat/uc-v2-filtres-projets`,
  `fix/…`, `chore/…`, `docs/…`.
- Commits au format **Conventional Commits** en français : `feat(projets): ajoute les filtres par catégorie`.
- **N'ajoute jamais de ligne `Co-Authored-By`, de mention "Generated with Claude" ni aucune attribution
  à une IA** dans les commits, les PR, les issues ou le code. L'auteur est le propriétaire du dépôt.
- Une PR = un use case (ou une tâche technique). PR petite, description remplie selon
  `.github/pull_request_template.md`, avec captures avant/après pour l'UI.
- N'exécute jamais `git push --force` sur `main`, ne modifie pas l'historique publié.

### Fidélité à la maquette
- La maquette fait foi : `docs/design/maquettes/*.dc.html` (markup + styles) et
  `docs/design/screens/*.png` (rendu). Utilise le skill `maquette-fidele` pour tout travail d'UI.
- Ne crée pas de nouvelle couleur, police, taille ou rayon : utilise les tokens.
- Ne réinvente pas un composant qui existe dans `src/components/ui/`.

### Données & sécurité
- Toute lecture publique passe par `src/lib/data/*` et ne renvoie que le contenu `published`/`enabled`.
- Les écritures passent par des Server Actions dans `src/lib/actions/*`, validées par Zod,
  et vérifient que l'utilisateur est admin. La RLS Supabase reste la dernière barrière.
- La clé `service_role` n'est jamais utilisée côté client ni committée. Ne lis pas les fichiers `.env*`.
- Toute modification du schéma = une nouvelle migration dans `supabase/migrations/`, puis `npm run db:types`.

### Code
- TypeScript strict, pas de `any`. Composants serveur par défaut, `"use client"` seulement si nécessaire
  (filtres, carrousels, pop-up, sélecteur de langue, formulaires).
- Accessibilité : vrais `<button>`/`<a>`, `aria-label` sur les boutons-icônes, focus visible,
  pop-up avec piège de focus + fermeture `Échap`, cibles ≥ 44px, contraste AA.
- Tout texte visible existe en FR **et** EN.

## Definition of Done (par PR)
1. Le use case de `docs/use-cases.md` est satisfait (critères d'acceptation cochés).
2. Le rendu correspond à la maquette (desktop 1440 et mobile 390).
3. Lint, typecheck, tests et build passent ; un test couvre le comportement principal.
4. PR ouverte avec le template rempli, sans attribution IA.

## Où trouver quoi
- Use cases et critères : `docs/use-cases.md`
- Architecture et modèle de données : `docs/architecture.md`
- Plan sur 2 jours (ordre des PR) : `docs/plan.md`
- Tokens et règles visuelles : `docs/design/tokens.md`
