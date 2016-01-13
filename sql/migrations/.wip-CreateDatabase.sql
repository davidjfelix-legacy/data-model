create table users (
  id uuid primary key unique default uuid_generate_v4() not null
);

create table user_address(
  id uuid primary key unique default uuid_generate_v4() not null,
  address_line_one text not null,
  address_line_two text,
  address_line_three text,
  city text not null,
  state_code text not null,
  country_code text not null,
  postal_code text not null
);

create table user_address_type (
  id uuid primary key unique default uuid_generate_v4() not null,
  user_id uuid references users(id) not null,
  address_id uuid references user_address(id) not null,
  address_type text not null
);

create table oauth_providers (
  id uuid unique default uuid_generate_v4() not null,
  provider text unique not null,
  primary key (id, provider)
);

create table oauth_claims (
  id uuid unique default uuid_generate_v4() not null,
  provider_uid text not null,
  provider_id uuid references oauth_providers(id) not null,
  user_id uuid references users(id),
  primary key (id, provider_uid, provider_id) 
);

create table sellers (
  id uuid unique default uuid_generate_v4() not null,
  user_id uuid unique references users(id) not null on delete restrict,
  primary key (id, user_id)
);

create table buyers (
  id uuid unique default uuid_generate_v4() not null,
  user_id uuid unique references users(id) not null on delete restrict,
  primary key (id, user_id)
);


