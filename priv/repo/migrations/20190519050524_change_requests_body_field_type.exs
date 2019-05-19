defmodule Cuyhooks.Repo.Migrations.ChangeRequestsBodyFieldType do
  use Ecto.Migration

  def change do
    alter table(:requests) do
      modify(:body, :text)
    end
  end
end
