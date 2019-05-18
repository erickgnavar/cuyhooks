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
      "body" => "",
      "hook" => key
    }

    # TODO: add request body to request creation

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
    requests = Requests.list_requests_by_hook(key)
    requests_quantity = length(requests)
    render(conn, "live.html", key: key, requests: requests, requests_quantity: requests_quantity)
  end
end
