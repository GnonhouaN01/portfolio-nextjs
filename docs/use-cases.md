# Use cases

Deux acteurs : **Visiteur** (recruteur, client, curieux, sans compte) et **Admin** (le propriétaire, connecté).
Chaque use case = une issue GitHub = une branche = une PR. L'écran de référence est indiqué pour chaque cas.

---

## Visiteur

### UC-V1 — Découvrir le profil
**Écran** : `Main.dc.html` NAV, HERO, CHIFFRES, 01 À PROPOS · `site-hero.png`
**Scénario** : le visiteur arrive sur `/fr`, voit le nom, le titre, la disponibilité, l'éditeur `profil.ts`,
les chiffres clés et la section À propos.
**Critères d'acceptation**
- [ ] Nom, titre, disponibilité, bio, photo et chiffres viennent de la table `profile`.
- [ ] Le code en arrière-plan n'apparaît que dans la moitié droite du hero (`aria-hidden`).
- [ ] Boutons « Voir mes projets » et « Me contacter » défilent vers les ancres ; « Télécharger mon CV » ouvre le PDF.
- [ ] Rendu conforme à 1440px et 390px.

### UC-V2 — Parcourir et filtrer les projets
**Écran** : `Main.dc.html` 02 PROJETS · `site-projets.png`
**Scénario** : le visiteur filtre par catégorie (Tous, Web, Mobile, Back-end/API, UI/UX) et fait défiler
le carrousel quand il y a plus de 3 projets.
**Critères d'acceptation**
- [ ] Seuls les projets `published` s'affichent, triés par `sort_order`, les mis en avant en premier.
- [ ] Chaque filtre affiche son compteur ; le filtre actif a `aria-pressed="true"`.
- [ ] 3 cartes par page sur desktop ; flèches, points et compteur « 01 / 03 » seulement s'il y a plus d'une page.
- [ ] Changer de filtre revient à la page 1.
- [ ] Badge « Expérience professionnelle » sur les projets `is_professional`.

### UC-V3 — Voir le détail d'un projet (pop-up)
**Écran** : `Main.dc.html` « Détail d'un projet : pop-up » · `site-popup-projet.png`
**Scénario** : clic sur une carte → pop-up par-dessus la page avec captures (carrousel), titre, description,
rôle, fonctionnalités, résultat, stack, liens démo et code ; navigation précédent/suivant.
**Critères d'acceptation**
- [ ] L'URL devient `?projet=<slug>` (lien partageable, ouverture directe possible).
- [ ] Fermeture par le bouton ×, la touche `Échap` et un clic sur le fond ; le focus revient sur la carte.
- [ ] Focus piégé dans la pop-up, `role="dialog"` et `aria-modal="true"`, défilement de la page bloqué.
- [ ] Les liens démo/code sont masqués s'ils sont vides.
- [ ] Plein écran défilant sur mobile.

### UC-V4 — Consulter l'expérience et le parcours
**Écran** : `Main.dc.html` 03 · `site-parcours.png`
**Critères d'acceptation**
- [ ] Deux cartes « git log » (expérience, formation) alimentées par `timeline_entries`.
- [ ] Chaque carte est un carrousel : flèches, frise de points cliquables, compteur « 2 / 3 ».
- [ ] L'entrée « HEAD → prochaine étape » apparaît en premier dans Expérience.

### UC-V5 — Lire la roadmap, les compétences et les articles
**Écran** : `Main.dc.html` 04, 05, 06 · `site-bas-de-page.png`
**Critères d'acceptation**
- [ ] Roadmap (`roadmap_items`) et compétences (`skills_groups`) viennent de la base.
- [ ] La section Blog n'apparaît que si elle est activée dans `site_sections` et qu'il y a au moins un article publié.
- [ ] `/fr/blog` liste les articles, `/fr/blog/<slug>` affiche l'article (Markdown rendu).
- [ ] L'ordre et la visibilité de toutes les sections suivent `site_sections`.

### UC-V6 — Changer la langue
**Critères d'acceptation**
- [ ] Le sélecteur FR/EN bascule `/fr/...` ↔ `/en/...` en conservant la page et la pop-up ouverte.
- [ ] Interface et contenu sont traduits ; un contenu sans traduction EN retombe sur le FR.
- [ ] `<html lang>` et les métadonnées SEO suivent la langue.

### UC-V7 — Contacter
**Écran** : `Main.dc.html` CONTACT · `site-bas-de-page.png`
**Critères d'acceptation**
- [ ] Trois cartes en dur, sans formulaire : `mailto:`, profil LinkedIn, `https://wa.me/<numéro>`.
- [ ] Valeurs lues depuis `profile` ; les liens externes s'ouvrent dans un nouvel onglet avec `rel="noopener"`.

---

## Admin

### UC-A1 — Se connecter au dashboard
**Critères d'acceptation**
- [ ] `/fr/admin` redirige vers `/fr/admin/login` sans session.
- [ ] Connexion e-mail + mot de passe Supabase ; un compte absent de `admins` est refusé.
- [ ] Déconnexion depuis la barre latérale.

### UC-A2 — Vue d'ensemble
**Écran** : `Dashboard.dc.html` vue `overview` · `dash-vue-ensemble.png`
**Critères d'acceptation**
- [ ] Chiffres : projets publiés, sections actives, articles publiés.
- [ ] Checklist de complétion du profil et raccourcis (nouveau projet, nouvel article, ajouter une section).

### UC-A3 — Mettre à jour le profil et les contacts
**Écran** : vue `profile` · `dash-profil.png`
**Critères d'acceptation**
- [ ] Édition FR/EN du titre, de la bio, de la disponibilité ; e-mail, LinkedIn, WhatsApp, CV, photo.
- [ ] Validation Zod (e-mail valide, URL valide, numéro international).
- [ ] Après enregistrement, toast « Profil mis à jour sur le site » et site public à jour.

### UC-A4 — Gérer les projets
**Écrans** : vue `projects` liste + édition · `dash-projets.png`, `dash-projet-edition.png`
**Critères d'acceptation**
- [ ] Liste avec statut (publié/brouillon), mise en avant, catégorie, année.
- [ ] Créer / modifier / supprimer un projet ; onglets FR/EN ; slug généré depuis le titre.
- [ ] Upload de plusieurs captures (Storage `media`), réordonnables.
- [ ] « Enregistrer en brouillon » et « Publier » ; le site se met à jour sans redéploiement.

### UC-A5 — Gérer le parcours
**Écran** : vue `history` · `dash-parcours.png`
**Critères d'acceptation**
- [ ] Ajouter / modifier / supprimer / réordonner expériences et formations (FR/EN, dates, points clés).
- [ ] Les carrousels du site reflètent l'ordre défini.

### UC-A6 — Gérer les sections du site
**Écrans** : vue `sections` + bibliothèque · `dash-sections.png`, `dash-sections-ajout.png`
**Critères d'acceptation**
- [ ] Afficher/masquer et monter/descendre chaque section.
- [ ] Ajouter une section depuis la bibliothèque (Blog, Actualités…) : elle apparaît sur le site.

### UC-A7 — Publier un article ou une actualité
**Écrans** : vue `blog` + rédaction · `dash-blog.png`, `dash-blog-redaction.png`
**Critères d'acceptation**
- [ ] Rédaction FR/EN en Markdown, type (article, actualité, tutoriel), image de couverture, temps de lecture.
- [ ] Brouillon / publier / dépublier ; date de publication fixée à la première publication.

---

## Transverses (techniques)
- **UC-T1** Socle : Next.js, Tailwind + tokens, next-intl, layout, polices, CI.
- **UC-T2** Base : migrations, RLS, seed, types générés, clients Supabase.
- **UC-T3** Qualité : SEO (metadata, Open Graph, sitemap, robots), pages 404, Lighthouse ≥ 90.
- **UC-T4** Déploiement Vercel + variables d'environnement + domaine.
