FROM elixir:1.8 as prebuild

COPY . /app
WORKDIR /app

ENV MIX_ENV=prod

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only prod

FROM node:11-slim as assets

COPY . /app
WORKDIR /app/assets

COPY --from=prebuild /app/deps /app/deps

RUN npm install && ./node_modules/.bin/webpack --mode production

FROM elixir:1.8

COPY . /app
WORKDIR /app

ENV MIX_ENV=prod

COPY --from=assets /app/priv/static /app/priv/static

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only prod
RUN mix compile
RUN mix phx.digest
