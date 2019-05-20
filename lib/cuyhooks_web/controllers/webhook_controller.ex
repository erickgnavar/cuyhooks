defmodule CuyhooksWeb.WebhookController do
  use CuyhooksWeb, :controller
  alias CuyhooksWeb.Endpoint
  alias Cuyhooks.Requests

  def index(conn, _params = %{"key" => key}) do
    data = %{
      "headers" => Map.new(conn.req_headers),
      "querystring" => conn.query_string,
      "method" => conn.method,
      "host" => conn.host,
      "body" => conn.private[:raw_body],
      "hook" => key
    }

    {:ok, request} = Requests.create_request(data)

    topic = "webhooks:#{key}"
    Endpoint.broadcast(topic, "new_request", request)
    text(conn, "ok")
  end

  def create(conn, _params) do
    conn
    |> redirect(to: Routes.webhook_path(conn, :live, Ecto.UUID.generate()))
  end

  def live(conn, %{"key" => key}) do
    render(conn, "live.html", key: key)
  end
end
