defmodule CuyhooksWeb.WebhookController do
  use CuyhooksWeb, :controller
  alias CuyhooksWeb.Endpoint

  import Phoenix.LiveView.Controller

  def index(conn, params = %{"key" => key}) do
    payload = %{
      headers: conn.req_headers,
      query_string: conn.query_string,
      method: conn.method,
      host: conn.host,
      body: Map.drop(params, ["key"])
    }

    topic = "webhooks:#{key}"
    Endpoint.broadcast(topic, "new_request", payload)
    text(conn, "ok")
  end

  def create(conn, _params) do
    conn
    |> redirect(to: Routes.webhook_path(conn, :live, Ecto.UUID.generate()))
  end

  def live(conn, %{"key" => key}) do
    live_render(conn, CuyhooksWeb.WebhookLive, session: %{"key" => key})
  end
end
