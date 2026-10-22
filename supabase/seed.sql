-- Données de départ reprises de la maquette. Les valeurs entre [crochets] sont à remplacer
-- depuis le dashboard une fois en ligne.

insert into public.profile (id, full_name, headline, tagline, about_title, bio, availability, location, is_available,
  email, linkedin_url, whatsapp, stats, now_status)
values (1, 'Gnonhoua N''golo Ouattara',
  '{"fr":"Développeur Full Stack Web & Mobile","en":"Full Stack Web & Mobile Developer"}',
  '{"fr":"Développeur Full Stack Web & Mobile. Je conçois des applications claires, utiles et pensées pour durer en production.","en":"Full Stack Web & Mobile Developer. I build clear, useful applications designed to last in production."}',
  '{"fr":"J''aime quand une application marche vraiment — pour ceux qui l''utilisent.","en":"I like it when an app truly works — for the people using it."}',
  '{"fr":"Diplômé de l''ESATIC, j''ai passé 14 mois chez FlyFret à développer le site officiel et une plateforme interne de l''entreprise, de la conception à la mise en ligne.\n\nCe qui m''intéresse : transformer un besoin métier en un produit simple, rapide et facile à maintenir.","en":"An ESATIC graduate, I spent 14 months at FlyFret building the company website and an internal platform, from design to launch.\n\nWhat drives me: turning a business need into a product that is simple, fast and easy to maintain."}',
  '{"fr":"Disponible · CDI, freelance ou remote","en":"Available · full-time, freelance or remote"}',
  'Abidjan, Côte d''Ivoire', true,
  '[votre@email.com]', 'https://www.linkedin.com/in/gnonhoua-n-golo-ouattara-7b4180253', '[225XXXXXXXXXX]',
  '[{"value":{"fr":"14 mois","en":"14 months"},"label":{"fr":"d''expérience en entreprise","en":"of industry experience"}},
    {"value":{"fr":"[X]","en":"[X]"},"label":{"fr":"projets réalisés","en":"projects shipped"}},
    {"value":{"fr":"Web + Mobile","en":"Web + Mobile"},"label":{"fr":"de la maquette au déploiement","en":"from mockup to deployment"}},
    {"value":{"fr":"ESATIC","en":"ESATIC"},"label":{"fr":"Licence professionnelle · 2024","en":"Professional Bachelor · 2024"}}]',
  '{"learning":{"fr":"[technologie]","en":"[technology]"},"building":{"fr":"[projet perso]","en":"[side project]"},"languages":{"fr":"Français, Anglais [niveau]","en":"French, English [level]"}}')
on conflict (id) do nothing;

insert into public.projects (slug, categories, year, is_professional, is_featured, status, sort_order, title, summary, role, features, outcome, stack)
values
('flyfret-site', '{web}', '2025', true, true, 'published', 1,
 '{"fr":"FlyFret — Site officiel","en":"FlyFret — Official website"}',
 '{"fr":"Participation au développement du site officiel de l''entreprise d''expédition de colis, de la conception à la mise en ligne.","en":"Helped build the parcel shipping company website, from design to launch."}',
 '{"fr":"Développeur Full Stack (temps partiel). [Préciser votre périmètre]","en":"Full Stack Developer (part-time). [Specify your scope]"}',
 '{"fr":["[Fonctionnalité clé 1]","[Fonctionnalité clé 2]","[Fonctionnalité clé 3]"],"en":["[Key feature 1]","[Key feature 2]","[Key feature 3]"]}',
 '{"fr":"[Résultat chiffré]","en":"[Measurable result]"}', '{"[Front]","[Back]","[BDD]"}'),
('flyfret-plateforme', '{web,api}', '2025', true, true, 'published', 2,
 '{"fr":"FlyFret — Plateforme interne","en":"FlyFret — Internal platform"}',
 '{"fr":"Plateforme interne de l''entreprise. [Préciser : gestion des expéditions, suivi, tableaux de bord…]","en":"Company internal platform. [Specify: shipment management, tracking, dashboards…]"}',
 '{"fr":"Conception et développement. [Préciser votre rôle]","en":"Design and development. [Specify your role]"}',
 '{"fr":["[Fonctionnalité clé 1]","[Fonctionnalité clé 2]","[Fonctionnalité clé 3]"],"en":["[Key feature 1]","[Key feature 2]","[Key feature 3]"]}',
 '{"fr":"[Ex. X agents, Y colis suivis]","en":"[E.g. X agents, Y parcels tracked]"}', '{"[Front]","[API]","[BDD]"}'),
('application-mobile', '{mobile}', '[20XX]', false, false, 'draft', 3,
 '{"fr":"[Application mobile]","en":"[Mobile app]"}',
 '{"fr":"[Une phrase : le problème résolu et pour qui.]","en":"[One sentence: the problem solved and for whom.]"}',
 '{"fr":"[Votre rôle]","en":"[Your role]"}', '{"fr":[],"en":[]}', '{"fr":"","en":""}', '{"[Mobile]","[API]"}');

insert into public.timeline_entries (kind, hash, period, title, subtitle, points, is_next, sort_order) values
('experience', 'HEAD', '{"fr":"prochaine étape","en":"next step"}',
 '{"fr":"Rejoindre votre équipe ?","en":"Joining your team?"}',
 '{"fr":"Ouvert aux postes Full Stack — CDI, freelance ou remote.","en":"Open to Full Stack roles — full-time, freelance or remote."}',
 '{"fr":[],"en":[]}', true, 0),
('experience', 'a3f9c21', '{"fr":"févr. 2025 → mars 2026","en":"Feb 2025 → Mar 2026"}',
 '{"fr":"Développeur Full Stack · FlyFret","en":"Full Stack Developer · FlyFret"}',
 '{"fr":"Expédition de colis · Temps partiel · Abidjan, sur site","en":"Parcel shipping · Part-time · Abidjan, on-site"}',
 '{"fr":["Développement du site officiel de l''entreprise","Conception et développement d''une plateforme interne","[Un résultat chiffré]"],"en":["Built the company''s official website","Designed and built an internal platform","[A measurable result]"]}',
 false, 1),
('education', 'e8b42f0', '{"fr":"2021 → 2024","en":"2021 → 2024"}',
 '{"fr":"Licence professionnelle · Programmation informatique","en":"Professional Bachelor · Computer Programming"}',
 '{"fr":"ESATIC — École Supérieure Africaine des TIC, Abidjan","en":"ESATIC — African Higher School of ICT, Abidjan"}',
 '{"fr":["[Projet de fin d''études]","[Matières clés]"],"en":["[Final-year project]","[Key subjects]"]}', false, 0);

insert into public.skills_groups (label, items, sort_order) values
('{"fr":"/frontend","en":"/frontend"}', '{"[React]","[TypeScript]","[Tailwind]"}', 0),
('{"fr":"/backend","en":"/backend"}',   '{"[Node.js]","[API REST]","[SQL / NoSQL]"}', 1),
('{"fr":"/mobile","en":"/mobile"}',     '{"[Flutter]","[React Native]","[Firebase]"}', 2),
('{"fr":"/outils","en":"/tools"}',      '{"[Git / GitHub]","[Docker]","[Figma]","[Agile / Scrum]"}', 3);

insert into public.roadmap_items (version, horizon, title, body, bullets, color, sort_order) values
('v1.0', '{"fr":"maintenant","en":"now"}', '{"fr":"Intégrer une équipe produit","en":"Join a product team"}',
 '{"fr":"Contribuer comme développeur Full Stack sur un produit utilisé au quotidien, et progresser au contact de développeurs expérimentés.","en":"Contribute as a Full Stack developer to a product people use daily, and grow alongside experienced engineers."}',
 '{"fr":[],"en":[]}', 'syn-string', 0),
('v2.0', '{"fr":"2 à 3 ans","en":"2–3 years"}', '{"fr":"Me spécialiser","en":"Specialise"}',
 '{"fr":"Approfondir [architecture back-end / mobile / cloud] pour porter des décisions techniques sur des projets plus larges.","en":"Go deeper into [back-end architecture / mobile / cloud] to own technical decisions on larger projects."}',
 '{"fr":[],"en":[]}', 'syn-fn', 1),
('README.md', '{"fr":"","en":""}', '{"fr":"Ce qui me guide","en":"What guides me"}', '{"fr":"","en":""}',
 '{"fr":["L''utilisateur d''abord","Un code lisible par les autres","Apprendre en livrant"],"en":["Users first","Code others can read","Learn by shipping"]}',
 'syn-keyword', 2);

insert into public.site_sections (key, enabled, sort_order) values
('about', true, 1), ('projects', true, 2), ('timeline', true, 3), ('roadmap', true, 4),
('skills', true, 5), ('blog', false, 6), ('contact', true, 7)
on conflict (key) do nothing;
