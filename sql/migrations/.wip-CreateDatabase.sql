create table users (
  id uuid primary key default uuid_generate_v4()
);

create table sellers (
  id uuid default uuid_generate_v4(),
  user_id references users(id),
  primary key (id, user_id)
);

create table buyers (
  id uuid default uuid_generate_v4(),
  user_id references users(id) on delete restrict,
  primary key (id, user_id)
};
