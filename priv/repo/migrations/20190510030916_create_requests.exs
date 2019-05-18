defmodule Cuyhooks.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :hook, :uuid
      add :uid, :uuid
      add :method, :string
      add :host, :string
      add :body, :string
      add :headers, :map
      add :querystring, :string

      timestamps()
    end
  end
end
