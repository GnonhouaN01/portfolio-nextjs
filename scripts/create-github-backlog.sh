#!/usr/bin/env bash
# Crée les labels et les issues du plan (docs/plan.md) sur le dépôt GitHub courant.
# Prérequis : gh installé et authentifié (gh auth login), exécuté à la racine du dépôt.
set -euo pipefail

label() { gh label create "$1" --color "$2" --description "$3" --force >/dev/null; }

label "type: feature" "FF8A3D" "Nouvelle fonctionnalité"
label "type: chore"   "8B94A1" "Outillage, configuration"
label "type: bug"     "F87171" "Anomalie"
label "area: site"    "7AA2F7" "Site public"
label "area: admin"   "BB9AF7" "Dashboard"
label "area: db"      "9ECE6A" "Supabase"
label "jour 1"        "34D399" "Planifié jour 1"
label "jour 2"        "E0AF68" "Planifié jour 2"

issue() {
  # $1 titre, $2 labels, $3 corps
  gh issue create --title "$1" --label "$2" --body "$3" >/dev/null
  echo "✓ $1"
}

body() { printf 'Use case : %s — voir `docs/use-cases.md` (critères d'"'"'acceptation).\nBranche : `%s`\n' "$1" "$2"; }

issue "Socle Next.js, Tailwind, next-intl, qualité et CI" "type: chore,jour 1" "$(body UC-T1 chore/socle)"
issue "Schéma Supabase, RLS, seed et clients typés" "type: feature,area: db,jour 1" "$(body UC-T2 feat/base-supabase)"
issue "Tokens, primitives et layout du site" "type: feature,area: site,jour 1" "$(body 'UC-T1, UC-V6' feat/design-system)"
issue "Hero, chiffres et à propos" "type: feature,area: site,jour 1" "$(body UC-V1 feat/uc-v1-profil)"
issue "Grille des projets, filtres par catégorie et carrousel" "type: feature,area: site,jour 1" "$(body UC-V2 feat/uc-v2-projets)"
issue "Pop-up de détail projet accessible" "type: feature,area: site,jour 1" "$(body UC-V3 feat/uc-v3-popup-projet)"
issue "Parcours en carrousel, roadmap, compétences, contact" "type: feature,area: site,jour 2" "$(body 'UC-V4, UC-V5, UC-V7' feat/uc-v4-parcours)"
issue "Connexion admin, layout et vue d'ensemble" "type: feature,area: admin,jour 2" "$(body 'UC-A1, UC-A2' feat/uc-a1-auth-dashboard)"
issue "Édition du profil et des contacts" "type: feature,area: admin,jour 2" "$(body UC-A3 feat/uc-a3-profil)"
issue "Gestion des projets et des captures" "type: feature,area: admin,jour 2" "$(body UC-A4 feat/uc-a4-projets)"
issue "Parcours et sections du site (admin)" "type: feature,area: admin,jour 2" "$(body 'UC-A5, UC-A6' feat/uc-a5-a6-parcours-sections)"
issue "Blog public et rédaction d'articles" "type: feature,area: site,area: admin,jour 2" "$(body 'UC-V5, UC-A7' feat/uc-a7-blog)"
issue "SEO, tests e2e et déploiement Vercel" "type: chore,jour 2" "$(body 'UC-T3, UC-T4' chore/mise-en-ligne)"
