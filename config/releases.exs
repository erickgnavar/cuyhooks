import Config

config :cuyhooks, CuyhooksWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [host: System.get_env("DOMAIN")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  live_view: [signing_salt: System.get_env("SECRET_KEY_BASE")]

config :cuyhooks, Cuyhooks.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("PG_POOL_SIZE", "20"))
