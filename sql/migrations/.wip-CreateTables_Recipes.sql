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

create table user_address_mqpings (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references users not null,
  address_id uuid references user_address not null,
  address_type text not null
);

create table oauth_providers (
  id uuid unique default uuid_generate_v4() not null,
  provider text unique not null,
  primary key (id, provider)
);

create table oauth_claims (
  id uuid unique default uuid_generate_v4() not null,
  provider_uid text,
  provider_id uuid references oauth_providers(id) not null,
  user_id uuid references users(id) not null,
  primary key (id, provider_uid)
);

create table sellers (
  id uuid unique default uuid_generate_v4(),
  user_id uuid references users(id) on delete restrict,
  primary key (id, user_id)
);

create table buyers (
  id uuid unique default uuid_generate_v4(),
  user_id uuid references users(id) on delete restrict,
  primary key (id, user_id)
);

create table recipes(
  id uuid primary key unique default uuid_generate_v4() not null,
  recipe_name text not null,
  recipe_description text not null,
  recipe_url text not null
);

create table allergens(
  id uuid primary key unique default uuid_generate_v4() not null,
  allergen text not null
);

create table ingredients(
  id uuid primary key unique default uuid_generate_v4() not null,
  ingredient text not null
);

create table recipe_meta_tags(
  id uuid unique default uuid_generate_v4() not null,
  recipe_id uuid references recipes(id),
  tag text not null,
  primary key(id, recipe_id)
);

create table recipe_allergen_information(
  id uuid primary key unique default uuid_generate_v4() not null,
  recipe_id uuid not null references recipes(id),
  allergen_id uuid not null references allergens(id)
);

create table recipes_ingredients_quantity(
  id uuid unique default uuid_generate_v4() not null,
  recipe_id uuid references recipes(id) not null,
  quantity integer not null,
  primary key (id, recipe_id)
);

create table favorites(
  id uuid unique default uuid_generate_v4() not null,
  seller_id uuid references sellers(id),
  buyer_id uuid references buyer_id(id),
  recipes_id uuid references recipes(id),
  primary key(id, seller_id, buyer_id, recipe_id)
);

create table meals(
  id uuid primary key unique default uuid_generate_v4() not null,
  seller_id uuid references sellers(id) not null,
  recipie_id uuid references recipes(id) not null,
  quantity integer not null,
  comments text
)

create table order(
  id uuid unique default uuid_generate_v4() not null,
  buyer_id references buyers(id) not null,
  seller_id references sellers(id) not null,
  recipe_id references recipes(id) not null,
  primary key(id, buyer_id, seller_id, recipe_id),
  quantity integer not null
)