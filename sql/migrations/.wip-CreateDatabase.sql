create table users (
  id uuid primary key unique default uuid_generate_v4() not null
);

create table oauth_claims (
  id uuid unique default uuid_generate_v4() not null,
  provider_uid text not null,
  provider_id references oauth_providers(id) not null,
  user_id references users(id),
  primary key (id, provider_uid, provider_id) 
);

create table oauth_providers (
  id uuid unique default uuid_generate_v4() not null,
  provider text unique not null,
  primary key (id, provider)

create table sellers (
  id uuid unique default uuid_generate_v4() not null,
  user_id unique references users(id) not null on delete restrict,
  primary key (id, user_id)
);

create table buyers (
  id uuid unique default uuid_generate_v4() not null,
  user_id unique references users(id) not null on delete restrict,
  primary key (id, user_id)
);
