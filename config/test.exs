import Config

config :cuyhooks, CuyhooksWeb.Endpoint,
  http: [port: 4002],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  live_view: [signing_salt: System.get_env("SECRET_KEY_BASE")],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cuyhooks, Cuyhooks.Repo,
  username: "postgres",
  password: "postgres",
  database: "cuyhooks_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
