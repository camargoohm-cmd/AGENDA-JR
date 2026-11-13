-- Agenda JR Studio · cole este código no Supabase: SQL Editor → New query → Run
create table if not exists public.docs (
  path text primary key,
  col text not null,
  data jsonb not null,
  owner uuid not null default auth.uid() references auth.users(id) on delete cascade,
  updated_at timestamptz default now()
);
create index if not exists docs_col_idx on public.docs (col);
alter table public.docs enable row level security;
create policy "dono le" on public.docs for select using (owner = auth.uid());
create policy "dono cria" on public.docs for insert with check (owner = auth.uid());
create policy "dono altera" on public.docs for update using (owner = auth.uid()) with check (owner = auth.uid());
create policy "dono apaga" on public.docs for delete using (owner = auth.uid());
