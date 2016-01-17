create extension if not exists "uuid-ossp";

create table users (
  id uuid primary key default uuid_generate_v4()
);

create table user_address(
  id uuid primary key default uuid_generate_v4(),
  address_line_one text not null,
  address_line_two text not null,
  address_line_three text not null,
  city text not null,
  state_code text not null,
  country_code text not null,
  postal_code text not null
);

create table user_address_type (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references users not null,
  address_id uuid references user_address not null,
  address_type text not null
);

create table oauth_providers (
  id uuid default uuid_generate_v4(),
  provider text unique not null,
  primary key (id, provider)
);

create table oauth_claims (
  id uuid default uuid_generate_v4(),
  provider_uid text not null,
  provider_id uuid references oauth_providers(id),
  user_id uuid references users(id),
  primary key (id, provider_uid, provider_id) 
);

create table sellers (
  id uuid default uuid_generate_v4(),
  user_id uuid references(id) on delete restrict,
  primary key (id, user_id)
);

create table buyers (
  id uuid default uuid_generate_v4(),
  user_id uuid references users(id) on delete restrict,
  primary key (id, user_id)
);


