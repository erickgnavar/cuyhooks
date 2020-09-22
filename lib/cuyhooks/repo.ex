defmodule Cuyhooks.Repo do
  use Ecto.Repo,
    otp_app: :cuyhooks,
    adapter: Ecto.Adapters.Postgres
end
