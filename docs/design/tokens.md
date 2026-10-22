# Design tokens

Extraits de la maquette (`docs/design/maquettes/`). Ce sont les **seules** valeurs autorisées.
À déclarer dans `src/app/globals.css` (Tailwind v4, bloc `@theme`) sous ces noms.

## Couleurs

| Token | Valeur | Usage |
| --- | --- | --- |
| `bg` | `#15181E` | fond de page |
| `bg-alt` | `#191D24` | sections alternées (Projets, Roadmap, Blog) |
| `bg-deep` | `#101318` | contact, footer, terminaux, vignettes de projet, sidebar admin |
| `surface` | `#1C2027` | cartes, pop-up, chips inactifs |
| `surface-2` | `#252A33` | tags de stack, boutons secondaires pleins |
| `bar` | `#161A20` | barres de titre de fenêtre, en-têtes |
| `line` | `#2D333D` | bordures de cartes |
| `line-strong` | `#3A414D` | bordures de boutons, chips |
| `divider` | `#262B34` | séparateurs de sections |
| `text` | `#ECEEF2` | texte courant |
| `heading` | `#FFFFFF` | titres |
| `text-2` | `#C2C8D1` | paragraphes secondaires |
| `text-3` | `#B6BDC8` | descriptions, liens de nav |
| `muted` | `#A0A8B4` | légendes, métadonnées |
| `faint` | `#8B94A1` | compteurs, dates (≥ 12px uniquement) |
| `accent` | `#FF8A3D` | accent unique (CTA, eyebrows, filtre actif, curseur) |
| `on-accent` | `#15181E` | texte sur fond accent |
| `success` | `#34D399` | pastille « disponible » |
| `success-bg` | `#17241E` | fond badge publié / disponible |
| `success-line` | `#2E3E36` | bordure badge publié |
| `success-fg` | `#B8E7CF` | texte badge publié |
| `draft-bg` | `#2A2620` | fond badge brouillon |
| `draft-fg` | `#F2D2A9` | texte badge brouillon |

Coloration syntaxique (éditeur `profil.ts`, vignettes, frise) : `syn-keyword #BB9AF7`, `syn-fn #7AA2F7`,
`syn-string #9ECE6A`, `syn-number #E0AF68`, `syn-comment #7C8592`, `syn-lineno #4E5561`.
Points de fenêtre : `#F87171`, `#FBBF24`, `#34D399`.

## Typographie
- **Sora** (400, 500, 600, 700) : tout le texte. Via `next/font/google`, variable `--font-sans`.
- **JetBrains Mono** (400, 500) : eyebrows, chips, tags, terminaux, hash, dates. Variable `--font-mono`.

| Rôle | Taille / interligne | Graisse | Espacement |
| --- | --- | --- | --- |
| H1 hero | 56px / 1.08 | 700 | -0.03em |
| H2 section | 38px / 1.18 | 600 | -0.02em |
| H2 contact | 44px / 1.12 | 600 | -0.02em |
| Titre pop-up | 28px / 1.2 | 600 | -0.02em |
| H3 carte | 20px / 1.3 | 600 | — |
| Accroche hero | 22px / 1.5 | 400 | — |
| Corps | 17px / 1.6 (sections) · 15px (cartes) | 400 | — |
| Eyebrow | 14px mono | 400 | 0.08em, MAJUSCULES, format « 02 — PROJETS » |
| Tag / meta | 12–13px mono | 400–500 | 0.06em pour les catégories |

Mobile : H1 36px, H2 28px, H2 contact 32px.

## Espacements, rayons, ombres
- Conteneur : `max-width: 1160px`, gouttière 24px.
- Sections : `padding: 96px 24px` (mobile 64px 16px). Gaps : 56 (colonnes), 40 (titre → contenu), 24 (grilles).
- Rayons : 6 (tags), 8 (petits boutons), 10 (boutons), 12 (blocs internes), 14 (cartes), 18 (pop-up), 999 (chips, pastilles).
- Cibles tactiles ≥ 44px. Boutons ronds de carrousel 44–48px.
- Ombre unique (pop-up) : `0 32px 90px rgba(0,0,0,.55)` ; fond de pop-up `rgba(8,10,13,.8)`.

## Motifs signature
- **Code en arrière-plan** : hero uniquement, moitié droite, mono 13px, couleur `rgba(236,238,242,.05)`,
  masque `linear-gradient(to left, #000 55%, transparent)`.
- **Fenêtre terminal** : barre `bar` + 3 points + nom de fichier mono ; corps `bg-deep`.
- **Git log** : frise de points reliés (actif : rond plein + halo), hash + date en mono accent.
- **Logo** : `<NO/>` en mono accent dans un cadre `line-strong`.
