FROM elixir:1.9-alpine as build

ENV MIX_ENV=prod

# install build dependencies
RUN apk --update add nodejs npm git build-base

WORKDIR /app

# setup hex + rebar
RUN mix local.hex --force && mix local.rebar --force

# install mix dependencies
COPY mix.exs .
COPY mix.lock .
COPY config config

RUN mix do deps.get --only=prod, compile

# build assets
COPY assets assets
COPY priv priv

RUN cd assets && npm install && npm run deploy
RUN mix phx.digest

# build project
COPY lib lib
RUN mix compile

RUN mix release

FROM alpine:3.9

RUN apk add --update bash openssl

WORKDIR /rel

COPY --from=build /app/_build/prod/rel/ .

CMD /rel/cuyhooks/bin/cuyhooks start
