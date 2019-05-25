defmodule CuyhooksWeb.WebhookView do
  use CuyhooksWeb, :view
  import Plug.Conn

  def to_json(value), do: Jason.encode!(value)

  def add_host_to_url(conn, url) do
    scheme =
      case get_req_header(conn, "x-forwarded-proto") do
        [value] -> value
        [] -> conn.scheme
      end

    [host] = get_req_header(conn, "host")
    "#{scheme}://#{host}#{url}"
  end
end
