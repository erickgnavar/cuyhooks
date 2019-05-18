defmodule Cuyhooks.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :body, :string
    field :headers, :map
    field :hook, Ecto.UUID
    field :host, :string
    field :method, :string
    field :querystring, :string
    field :uid, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [
      :hook,
      :uid,
      :method,
      :host,
      :body,
      :headers,
      :querystring
    ])
    |> validate_required([:hook, :method, :host, :headers])
    |> put_change(:uid, Ecto.UUID.generate())
  end
end
