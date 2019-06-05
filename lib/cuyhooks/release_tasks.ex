defmodule Cuyhooks.ReleaseTasks do
  def migrate() do
    {:ok, _} = Application.ensure_all_started(:cuyhooks)

    path = Application.app_dir(:cuyhooks, "priv/repo/migrations")

    Ecto.Migrator.run(Cuyhooks.Repo, path, :up, all: true)
  end
end
