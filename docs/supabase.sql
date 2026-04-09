create table if not exists public.settings (
  id integer primary key check (id = 1),
  opening_times text,
  special_notice text,
  phone_number text,
  email text,
  address text,
  reservation_note text,
  updated_at timestamptz not null default now()
);

insert into public.settings (
  id,
  opening_times,
  special_notice,
  phone_number,
  email,
  address,
  reservation_note
)
values (
  1,
  'Montag - Freitag 11:30 - 14:30\nSamstag geschlossen\nSonntag geschlossen',
  'Mittagstisch mit wechselnden Tagesgerichten.',
  'wird aktualisiert',
  'kontakt@tante-edith.de',
  'Humboldtstrasse 16, 76131 Karlsruhe',
  'Reservierungen und Gruppenanfragen bitte direkt vor Ort abstimmen.'
)
on conflict (id) do nothing;

alter table public.settings enable row level security;

drop policy if exists settings_select_public on public.settings;
create policy settings_select_public
on public.settings
for select
to anon, authenticated
using (true);

drop policy if exists settings_update_authenticated on public.settings;
create policy settings_update_authenticated
on public.settings
for update
to authenticated
using (id = 1)
with check (id = 1);
