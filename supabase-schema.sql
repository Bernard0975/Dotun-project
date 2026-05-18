-- Supabase schema for Resource Booking System
-- Run this SQL in your Supabase project's SQL editor.

-- Profiles table
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text not null unique,
  email text not null unique,
  role text not null check (role in ('admin', 'lecturer', 'student'))
);

-- Resources table
create table if not exists resources (
  id serial primary key,
  name text not null unique,
  type text not null check (type in ('lab', 'class', 'projector'))
);

-- Bookings table
create table if not exists bookings (
  id serial primary key,
  user_id uuid not null references profiles(id) on delete cascade,
  resource_id int not null references resources(id) on delete cascade,
  start_time timestamptz not null,
  end_time timestamptz not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected', 'cancelled')),
  purpose text not null,
  created_at timestamptz not null default now()
);

-- Notifications table
create table if not exists notifications (
  id serial primary key,
  user_id uuid not null references profiles(id) on delete cascade,
  title text not null,
  message text not null,
  type text not null,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

-- Enable RLS and policies
alter table profiles enable row level security;
create policy "Profiles: authenticated select" on profiles
  for select using (auth.role() is not null);
create policy "Profiles: insert own profile" on profiles
  for insert with check (auth.uid() = id);
create policy "Profiles: update own profile" on profiles
  for update using (auth.uid() = id) with check (auth.uid() = id);

alter table resources enable row level security;
create policy "Resources: authenticated select" on resources
  for select using (auth.role() is not null);

alter table bookings enable row level security;
create policy "Bookings: select own or admin" on bookings
  for select using (auth.uid() = user_id or auth.role() = 'admin');
create policy "Bookings: insert own booking" on bookings
  for insert with check (auth.uid() = user_id);
create policy "Bookings: update own or admin" on bookings
  for update using (auth.uid() = user_id or auth.role() = 'admin');

alter table notifications enable row level security;
create policy "Notifications: select own" on notifications
  for select using (auth.uid() = user_id);
create policy "Notifications: insert authenticated" on notifications
  for insert with check (auth.role() is not null);
create policy "Notifications: update own" on notifications
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Seed default resources
insert into resources (name, type) values
  ('hwlab', 'lab'),
  ('swlab', 'lab'),
  ('cmplh', 'class'),
  ('clr1', 'class'),
  ('clr2', 'class'),
  ('clr3', 'class'),
  ('clr4', 'class'),
  ('clr5', 'class'),
  ('projector 1', 'projector'),
  ('projector 2', 'projector'),
  ('projector 3', 'projector'),
  ('projector 4', 'projector'),
  ('projector 5', 'projector')
on conflict do nothing;
