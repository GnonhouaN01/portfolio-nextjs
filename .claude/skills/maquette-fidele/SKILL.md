---
name: maquette-fidele
description: Règles pour reproduire fidèlement la maquette du portfolio et du dashboard. À utiliser pour toute création ou modification d'interface (pages, sections, composants, styles Tailwind, responsive).
paths:
  - "src/app/**"
  - "src/components/**"
  - "src/app/globals.css"
---

# Fidélité à la maquette

La maquette fait foi. Ton travail est de la **traduire**, pas de la réinterpréter.

## 1. Avant d'écrire du code UI
1. Identifie l'écran concerné dans le tableau ci-dessous et lis la portion correspondante de la maquette
   (cherche le commentaire `<!-- ====… -->` de la section).
2. Si une capture existe dans `docs/design/screens/`, ouvre-la et regarde-la.
3. Relis `docs/design/tokens.md`.

| Écran | Maquette (markup + styles) | Capture |
| --- | --- | --- |
| Site : nav, hero, chiffres, à propos | `docs/design/maquettes/Main.dc.html` (NAV, HERO, CHIFFRES, 01) | `site-hero.png` |
| Site : projets, filtres, carrousel | `Main.dc.html` (02 PROJETS) | `site-projets.png` |
| Site : pop-up détail projet | `Main.dc.html` (« Détail d'un projet : pop-up ») | `site-popup-projet.png` |
| Site : parcours (carrousels git log) | `Main.dc.html` (03) | `site-parcours.png` |
| Site : roadmap, compétences, blog, contact, footer | `Main.dc.html` (04 → FOOTER) | `site-bas-de-page.png` |
| Dashboard (tous les onglets) | `docs/design/maquettes/Dashboard.dc.html` (un bloc `v.<onglet>` par onglet) | `dash-*.png` |

Les fichiers `.dc.html` utilisent un moteur de maquette : ignore `<sc-if>`, `<sc-for>`, `{{…}}` et le
`<script>` de fin. Ce qui compte : la hiérarchie HTML, les textes, et les styles inline, que tu convertis
en classes Tailwind basées sur les tokens. Les données d'exemple du `<script>` montrent la forme des
données (catégories, champs d'un projet, entrées du parcours).

## 2. Règles de traduction
- **Couleurs** : uniquement les tokens (`bg-surface`, `text-muted`, `border-line`, `text-accent`…).
  Une valeur hex absente de `tokens.md` est une erreur : demande avant d'en ajouter.
- **Typo** : `font-sans` (Sora) pour le texte, `font-mono` (JetBrains Mono) pour les eyebrows, tags,
  chips, terminaux, hash git. Respecte tailles, graisses et `letter-spacing` de la maquette.
- **Espacements & rayons** : reprends les valeurs de la maquette (sections `py-24 px-6`, conteneur
  `max-w-[1160px]`, cartes `rounded-[14px]`, pop-up `rounded-[18px]`, chips `rounded-full`).
- **Code en arrière-plan** : seulement dans la moitié droite du hero, en `aria-hidden`, opacité ~5 %,
  avec le masque dégradé. Nulle part ailleurs.
- **Textes** : reprends les textes de la maquette mot pour mot, via `messages/{fr,en}.json` ou la base.
  Les textes entre `[crochets]` sont des emplacements de contenu : ils viennent de Supabase.
- **Icônes** : SVG inline à trait (stroke 1.8–2), jamais d'emoji.
- **Responsive** : desktop de référence 1440px, mobile 390px. Les grilles passent en une colonne,
  la nav se replie, la pop-up devient plein écran défilant.

## 3. Composants à réutiliser (créer une seule fois dans `src/components/ui/`)
`Eyebrow` (« 01 — À PROPOS »), `SectionHeading`, `Chip` (filtre actif/inactif + compteur), `Tag` (stack mono),
`Card`, `IconButton` (rond 44–48px), `CarouselDots`, `TerminalWindow` (3 points + titre de fichier),
`CommitTimeline` (points + ligne), `StatusBadge` (publié/brouillon), `LangSwitch`.

## 4. Vérification avant de finir
1. Lance `npm run dev` et, si le serveur MCP Playwright est disponible, fais une capture à 1440 et 390px
   de l'écran modifié, puis compare-la à la capture de référence.
2. Liste dans la PR les écarts restants, s'il y en a, et pourquoi.
