-- ============================================================
-- ContentFlow — Schema SQL
-- Ejecuta esto en Supabase > SQL Editor > New Query
-- ============================================================

-- POSTS table
create table if not exists posts (
  id          bigserial primary key,
  title       text not null,
  platform    text not null,
  date        date not null,
  time        text not null default '09:00',
  status      text not null default 'Borrador',
  type        text not null default 'Imagen',
  goal        text,
  owner       text,
  copy        text,
  hashtags    text,
  tags        text[],
  notes       text,
  media_url   text,
  media_type  text,
  created_at  timestamptz default now(),
  updated_at  timestamptz default now()
);

-- CAROUSEL SLIDES table
create table if not exists carousel_slides (
  id         bigserial primary key,
  post_id    bigint not null references posts(id) on delete cascade,
  position   int not null default 0,
  media_url  text not null,
  media_type text not null default 'image/jpeg',
  created_at timestamptz default now()
);

-- Index for fast lookup
create index if not exists idx_carousel_post_id on carousel_slides(post_id);
create index if not exists idx_posts_date on posts(date);

-- Auto-update updated_at
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists posts_updated_at on posts;
create trigger posts_updated_at
  before update on posts
  for each row execute function update_updated_at();

-- RLS (Row Level Security) — public read/write for now (single-team use)
alter table posts enable row level security;
alter table carousel_slides enable row level security;

drop policy if exists "public_all_posts" on posts;
create policy "public_all_posts" on posts for all using (true) with check (true);

drop policy if exists "public_all_slides" on carousel_slides;
create policy "public_all_slides" on carousel_slides for all using (true) with check (true);

-- Storage bucket (run separately if needed)
-- insert into storage.buckets (id, name, public) values ('contentflow-media', 'contentflow-media', true);
