---
name: i18n-contenu
description: Gestion du bilinguisme FR/EN (next-intl pour l'interface, champs jsonb pour le contenu). À utiliser pour tout texte visible, le sélecteur de langue, les routes [locale] et les formulaires admin avec onglets FR/EN.
---

# Bilinguisme FR / EN

## Deux sources de texte
1. **Textes d'interface** (menus, boutons, titres de sections, libellés) → `messages/fr.json` et
   `messages/en.json` via `next-intl` (`useTranslations` côté client, `getTranslations` côté serveur).
   Clés regroupées par zone : `nav.*`, `hero.*`, `projects.*`, `timeline.*`, `contact.*`, `admin.*`.
2. **Contenu éditable** (bio, projets, parcours, articles) → base Supabase, champs `jsonb {fr, en}`.
   Utilise le helper `pick(field, locale)` de `src/lib/i18n-content.ts` qui retombe sur le FR si l'EN est vide.

## Règles
- Routes : `/fr/...` et `/en/...`, `fr` par défaut, redirection de `/` vers la langue du navigateur.
- Le sélecteur FR/EN de la nav garde la page et l'ancre courantes ; `aria-pressed` sur le bouton actif.
- `<html lang>` suit la locale. Les métadonnées (`generateMetadata`) sont traduites.
- Aucune chaîne en dur dans un composant. Toute nouvelle clé est ajoutée dans les **deux** fichiers
  (le test `messages.test.ts` vérifie que les clés sont identiques).
- Formulaires admin : onglets FR / EN comme dans la maquette ; le FR est obligatoire, l'EN facultatif
  mais signalé par un badge « EN manquant » dans la liste.
- Dates : `Intl.DateTimeFormat(locale)` ; ex. « févr. 2025 → mars 2026 » / « Feb 2025 → Mar 2026 ».
