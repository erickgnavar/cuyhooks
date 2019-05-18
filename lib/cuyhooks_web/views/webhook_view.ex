defmodule CuyhooksWeb.WebhookView do
  use CuyhooksWeb, :view
  import Plug.Conn

  def to_json(value), do: Jason.encode!(value)

  def add_host_to_url(conn, url) do
    [host] = get_req_header(conn, "host")
    "#{conn.scheme}://#{host}#{url}"
  end
end
