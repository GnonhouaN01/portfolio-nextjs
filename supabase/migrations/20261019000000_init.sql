-- =====================================================================
-- Portfolio : schéma initial
-- Champs traduits en jsonb : {"fr": "...", "en": "..."} ou {"fr": [...], "en": [...]}
-- =====================================================================

create extension if not exists "pgcrypto";

-- ---------- Types ----------
create type public.content_status as enum ('draft', 'published');
create type public.timeline_kind  as enum ('experience', 'education');
create type public.post_kind      as enum ('article', 'news', 'tutorial');

-- ---------- Helpers ----------
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end $$;

-- Administrateurs (une ligne = un utilisateur Supabase Auth autorisé)
create table public.admins (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);

create or replace function public.is_admin()
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.admins where user_id = auth.uid());
$$;

-- ---------- Profil (ligne unique) ----------
create table public.profile (
  id            smallint primary key default 1 check (id = 1),
  full_name     text  not null,
  headline      jsonb not null default '{"fr":"","en":""}',
  tagline       jsonb not null default '{"fr":"","en":""}',
  about_title   jsonb not null default '{"fr":"","en":""}',
  bio           jsonb not null default '{"fr":"","en":""}',
  availability  jsonb not null default '{"fr":"","en":""}',
  location      text,
  is_available  boolean not null default true,
  email         text,
  linkedin_url  text,
  whatsapp      text,        -- format international sans espaces : 225XXXXXXXXXX
  github_url    text,
  cv_path       text,        -- chemin dans le bucket media
  photo_path    text,
  stats         jsonb not null default '[]',  -- [{ "value": {"fr","en"}, "label": {"fr","en"} }]
  now_status    jsonb not null default '{}',  -- { "learning": {"fr","en"}, "building": {...}, "languages": {...} }
  updated_at    timestamptz not null default now()
);

-- ---------- Projets ----------
create table public.projects (
  id              uuid primary key default gen_random_uuid(),
  slug            text not null unique check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  categories      text[] not null default '{}'
                  check (categories <@ array['web','mobile','api','design']::text[]),
  year            text,
  is_professional boolean not null default false,
  is_featured     boolean not null default false,
  status          public.content_status not null default 'draft',
  sort_order      int not null default 0,
  title           jsonb not null default '{"fr":"","en":""}',
  summary         jsonb not null default '{"fr":"","en":""}',
  role            jsonb not null default '{"fr":"","en":""}',
  features        jsonb not null default '{"fr":[],"en":[]}',
  outcome         jsonb not null default '{"fr":"","en":""}',
  stack           text[] not null default '{}',
  demo_url        text,
  repo_url        text,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);
create index projects_status_order_idx on public.projects (status, is_featured desc, sort_order);

create table public.project_images (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects (id) on delete cascade,
  path        text not null,
  alt         jsonb not null default '{"fr":"","en":""}',
  sort_order  int not null default 0,
  created_at  timestamptz not null default now()
);
create index project_images_project_idx on public.project_images (project_id, sort_order);

-- ---------- Parcours (expériences + formations) ----------
create table public.timeline_entries (
  id          uuid primary key default gen_random_uuid(),
  kind        public.timeline_kind not null,
  hash        text not null,                  -- ex. 'a3f9c21', 'HEAD', 'initial commit'
  period      jsonb not null default '{"fr":"","en":""}', -- ex. 'févr. 2025 → mars 2026'
  start_date  date,
  end_date    date,
  title       jsonb not null default '{"fr":"","en":""}',
  subtitle    jsonb not null default '{"fr":"","en":""}',
  points      jsonb not null default '{"fr":[],"en":[]}',
  is_next     boolean not null default false, -- carte « HEAD → prochaine étape »
  status      public.content_status not null default 'published',
  sort_order  int not null default 0,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index timeline_kind_order_idx on public.timeline_entries (kind, sort_order);

-- ---------- Compétences & roadmap ----------
create table public.skills_groups (
  id          uuid primary key default gen_random_uuid(),
  label       jsonb not null default '{"fr":"","en":""}', -- ex. '/frontend'
  items       text[] not null default '{}',
  sort_order  int not null default 0,
  updated_at  timestamptz not null default now()
);

create table public.roadmap_items (
  id          uuid primary key default gen_random_uuid(),
  version     text not null,                              -- 'v1.0', 'v2.0', 'README.md'
  horizon     jsonb not null default '{"fr":"","en":""}', -- 'maintenant', '2 à 3 ans'
  title       jsonb not null default '{"fr":"","en":""}',
  body        jsonb not null default '{"fr":"","en":""}',
  bullets     jsonb not null default '{"fr":[],"en":[]}',
  color       text not null default 'syn-string'
              check (color in ('syn-string','syn-fn','syn-keyword','accent')),
  sort_order  int not null default 0,
  updated_at  timestamptz not null default now()
);

-- ---------- Sections du site ----------
create table public.site_sections (
  key         text primary key
              check (key in ('about','projects','timeline','roadmap','skills','blog','news','contact')),
  enabled     boolean not null default true,
  sort_order  int not null default 0,
  title       jsonb,                          -- surcharge optionnelle du titre
  updated_at  timestamptz not null default now()
);

-- ---------- Blog & actualités ----------
create table public.posts (
  id              uuid primary key default gen_random_uuid(),
  slug            text not null unique check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
  kind            public.post_kind not null default 'article',
  title           jsonb not null default '{"fr":"","en":""}',
  excerpt         jsonb not null default '{"fr":"","en":""}',
  content         jsonb not null default '{"fr":"","en":""}', -- Markdown
  cover_path      text,
  reading_minutes int,
  status          public.content_status not null default 'draft',
  published_at    timestamptz,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);
create index posts_status_date_idx on public.posts (status, published_at desc);

-- ---------- Triggers updated_at ----------
create trigger trg_profile_updated    before update on public.profile          for each row execute function public.set_updated_at();
create trigger trg_projects_updated   before update on public.projects         for each row execute function public.set_updated_at();
create trigger trg_timeline_updated   before update on public.timeline_entries for each row execute function public.set_updated_at();
create trigger trg_skills_updated     before update on public.skills_groups    for each row execute function public.set_updated_at();
create trigger trg_roadmap_updated    before update on public.roadmap_items    for each row execute function public.set_updated_at();
create trigger trg_sections_updated   before update on public.site_sections    for each row execute function public.set_updated_at();
create trigger trg_posts_updated      before update on public.posts            for each row execute function public.set_updated_at();

-- Date de publication fixée à la première publication
create or replace function public.set_published_at()
returns trigger language plpgsql as $$
begin
  if new.status = 'published' and new.published_at is null then
    new.published_at = now();
  end if;
  return new;
end $$;
create trigger trg_posts_published before insert or update on public.posts
  for each row execute function public.set_published_at();

-- =====================================================================
-- RLS : lecture publique du contenu publié, écriture réservée aux admins
-- =====================================================================
alter table public.admins           enable row level security;
alter table public.profile          enable row level security;
alter table public.projects         enable row level security;
alter table public.project_images   enable row level security;
alter table public.timeline_entries enable row level security;
alter table public.skills_groups    enable row level security;
alter table public.roadmap_items    enable row level security;
alter table public.site_sections    enable row level security;
alter table public.posts            enable row level security;

-- admins : chacun peut vérifier sa propre ligne, aucune écriture depuis l'API
create policy "admins: lire sa ligne" on public.admins
  for select to authenticated using (user_id = auth.uid());

-- Lecture publique
create policy "profile: lecture publique"   on public.profile          for select using (true);
create policy "projects: publiés"           on public.projects         for select using (status = 'published' or public.is_admin());
create policy "images: projets publiés"     on public.project_images   for select using (
  public.is_admin() or exists (
    select 1 from public.projects p where p.id = project_id and p.status = 'published'
  )
);
create policy "timeline: publiés"           on public.timeline_entries for select using (status = 'published' or public.is_admin());
create policy "skills: lecture publique"    on public.skills_groups    for select using (true);
create policy "roadmap: lecture publique"   on public.roadmap_items    for select using (true);
create policy "sections: actives"           on public.site_sections    for select using (enabled or public.is_admin());
create policy "posts: publiés"              on public.posts            for select using (status = 'published' or public.is_admin());

-- Écriture admin
create policy "profile: admin"   on public.profile          for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "projects: admin"  on public.projects         for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "images: admin"    on public.project_images   for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "timeline: admin"  on public.timeline_entries for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "skills: admin"    on public.skills_groups    for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "roadmap: admin"   on public.roadmap_items    for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "sections: admin"  on public.site_sections    for all to authenticated using (public.is_admin()) with check (public.is_admin());
create policy "posts: admin"     on public.posts            for all to authenticated using (public.is_admin()) with check (public.is_admin());

-- =====================================================================
-- Storage : bucket public "media", écriture admin
-- =====================================================================
insert into storage.buckets (id, name, public)
values ('media', 'media', true)
on conflict (id) do nothing;

create policy "media: lecture publique" on storage.objects
  for select using (bucket_id = 'media');
create policy "media: upload admin" on storage.objects
  for insert to authenticated with check (bucket_id = 'media' and public.is_admin());
create policy "media: modif admin" on storage.objects
  for update to authenticated using (bucket_id = 'media' and public.is_admin());
create policy "media: suppression admin" on storage.objects
  for delete to authenticated using (bucket_id = 'media' and public.is_admin());
