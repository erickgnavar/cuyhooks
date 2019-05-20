defmodule CuyhooksWeb.Plugs.CopyReqBody do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    {:ok, body, _} = read_body(conn)
    put_private(conn, :raw_body, body)
  end
end
