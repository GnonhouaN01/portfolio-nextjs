---
name: ouvrir-pr
description: Vérifie, pousse la branche courante et ouvre une pull request propre avec le template du dépôt, sans attribution IA. Usage /ouvrir-pr
disable-model-invocation: true
---

# Ouvrir la pull request de la branche courante

1. Refuse si la branche courante est `main`.
2. Lance `npm run lint && npm run typecheck && npm run test && npm run build`. Si un contrôle échoue,
   corrige-le d'abord (ou arrête-toi et explique).
3. Vérifie les messages de commit de la branche (`git log main..HEAD --format=%B`) :
   - format Conventional Commits ;
   - **aucune** ligne `Co-Authored-By`, ni « Generated with », ni mention de Claude/Anthropic/IA.
   Si tu en trouves, signale-le et propose la correction ; ne réécris pas l'historique sans mon accord.
4. Pousse : `git push -u origin HEAD`.
5. Crée la PR avec `gh pr create --base main --title "<type>(<scope>): <résumé>" --body-file <fichier>`
   où le corps reprend **exactement** les rubriques de `.github/pull_request_template.md`, remplies :
   use case (`Closes #<issue>` si une issue existe), ce qui change, captures (indique les fichiers à
   joindre si tu ne peux pas les téléverser), comment tester, checklist cochée honnêtement.
   N'ajoute aucune signature, aucun lien de session, aucune mention d'IA en fin de description.
6. Affiche l'URL de la PR et l'état des checks (`gh pr checks`).
