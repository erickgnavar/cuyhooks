defmodule Cuyhooks.Release do
  @moduledoc """
  Run tasks inside releases.
  """
  @app :cuyhooks

  @doc """
  Run ecto migrations for each repo configured in the application.
  """
  @spec migrate :: any
  def migrate do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @doc """
  Run rollback until the given version.
  """
  @spec rollback(struct, String.t()) :: any
  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  @spec repos :: [struct]
  defp repos do
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
  end
end
