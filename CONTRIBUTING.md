# Contribuer

## Flux de travail
1. Une issue par use case (`docs/use-cases.md`).
2. Une branche depuis `main` à jour : `feat/uc-v2-filtres-projets`, `fix/…`, `chore/…`, `docs/…`.
3. Commits [Conventional Commits](https://www.conventionalcommits.org/fr/) : `feat(projets): ajoute les filtres`.
4. Pull request vers `main` avec le template rempli et des captures pour l'UI.
5. Merge en **squash** quand la CI est verte. La branche est supprimée après merge.

## Contrôles automatiques
- Local : `pre-commit` (ESLint + Prettier sur les fichiers modifiés), `commit-msg` (commitlint).
- GitHub Actions : lint, types, tests, build, e2e, titre de PR, absence d'attribution IA.

## Base de données
Toute modification du schéma passe par une migration dans `supabase/migrations/`, suivie de `npm run db:types`.
