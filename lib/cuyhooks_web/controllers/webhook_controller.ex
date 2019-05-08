defmodule CuyhooksWeb.WebhookController do
  use CuyhooksWeb, :controller
  alias CuyhooksWeb.Endpoint

  @topic "webhooks"

  def index(conn, params) do
    payload = %{
      headers: conn.req_headers,
      query_string: conn.query_string,
      method: conn.method,
      host: conn.host,
      body: params
    }

    Endpoint.broadcast(@topic, "new_request", payload)
    text(conn, "ok")
  end
end
