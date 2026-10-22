---
name: use-case
description: Réalise un use case de docs/use-cases.md de bout en bout (branche, plan, code, tests, vérification maquette, commit). Usage /use-case UC-V2
disable-model-invocation: true
argument-hint: "[UC-XX]"
---

# Réaliser le use case $ARGUMENTS

1. **Lire** l'entrée `$ARGUMENTS` dans `docs/use-cases.md` (acteur, scénario, critères d'acceptation,
   écran de maquette) et la ligne correspondante de `docs/plan.md`.
2. **Branche** : vérifie que l'arbre de travail est propre, mets `main` à jour (`git switch main && git pull`),
   puis crée `feat/<uc-id-en-minuscules>-<slug-court>` (ex. `feat/uc-v2-filtres-projets`).
3. **Plan** : avant de coder, présente-moi un plan court : fichiers créés/modifiés, composants
   réutilisés, données lues/écrites, tests prévus. Attends mon accord.
4. **Implémenter** en suivant les skills `maquette-fidele`, `supabase-data` et `i18n-contenu`.
   Petites étapes, un commit Conventional Commits par étape logique.
5. **Tester** : ajoute au moins un test (Vitest pour la logique, Playwright pour le parcours utilisateur
   décrit dans les critères). Lance `npm run lint && npm run typecheck && npm run test && npm run build`.
6. **Vérifier la maquette** : desktop 1440 et mobile 390 contre `docs/design/screens/`.
7. **Résumer** : critères d'acceptation cochés un par un, écarts restants, puis propose `/ouvrir-pr`.

Rappels : pas de commit sur `main`, aucune attribution IA dans les messages.
