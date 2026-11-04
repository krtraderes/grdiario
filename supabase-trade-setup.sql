-- KR Traders: dados privados do diário de trades, separados por usuário Supabase.
-- Execute este arquivo no SQL Editor do seu projeto Supabase.

create table if not exists public.trade_journal_private_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null check (jsonb_typeof(payload) = 'object'),
  updated_at timestamptz not null default now()
);

alter table public.trade_journal_private_data enable row level security;
revoke all on table public.trade_journal_private_data from public, anon, authenticated;
grant select, insert, update, delete on table public.trade_journal_private_data to authenticated;

drop policy if exists "trade_journal_owner_read" on public.trade_journal_private_data;
drop policy if exists "trade_journal_owner_insert" on public.trade_journal_private_data;
drop policy if exists "trade_journal_owner_update" on public.trade_journal_private_data;
drop policy if exists "trade_journal_owner_delete" on public.trade_journal_private_data;

create policy "trade_journal_owner_read"
  on public.trade_journal_private_data for select to authenticated
  using ((select auth.uid()) = user_id);

create policy "trade_journal_owner_insert"
  on public.trade_journal_private_data for insert to authenticated
  with check ((select auth.uid()) = user_id);

create policy "trade_journal_owner_update"
  on public.trade_journal_private_data for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "trade_journal_owner_delete"
  on public.trade_journal_private_data for delete to authenticated
  using ((select auth.uid()) = user_id);
-- Permite atualizações enquanto o diário está aberto em outros aparelhos.
do $$
begin
  alter publication supabase_realtime add table public.trade_journal_private_data;
exception
  when duplicate_object then null;
end $$;