---
name: verif-design
description: Compare le rendu local d'un écran avec la maquette (captures 1440px et 390px) et liste les écarts. Usage /verif-design site-projets
disable-model-invocation: true
argument-hint: "[nom-de-capture sans .png]"
context: fork
agent: design-reviewer
---

Compare l'écran `$ARGUMENTS` à sa référence `docs/design/screens/$ARGUMENTS.png`.

1. Vérifie que `npm run dev` tourne (sinon demande-moi de le lancer).
2. Avec le serveur MCP Playwright, ouvre la route correspondante, à 1440×900 puis 390×844,
   et fais une capture de chaque.
3. Compare avec la capture de référence et avec le markup de `docs/design/maquettes/`.
4. Rends un tableau : élément · attendu (maquette) · constaté · gravité (bloquant / mineur) · correction proposée
   (classe Tailwind ou composant à modifier). Ne modifie pas le code toi-même.
