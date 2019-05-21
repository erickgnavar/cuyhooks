defmodule CuyhooksWeb.Plugs.CopyReqBody do
  import Plug.Conn

  def init(opts), do: opts

  @doc """
  Fetch body content for /hook/hook_uid path
  this way the webhook controller will be able to read
  the request body and save it, this is necessary to avoid
  conflicts with others urls which require the parsers to work
  properly
  """
  def call(conn, _) do
    case conn.path_info do
      ["hook", rest] ->
        case Ecto.UUID.cast(rest) do
          {:ok, ^rest} ->
            {:ok, body, _} = read_body(conn)
            put_private(conn, :raw_body, body)

          :error ->
            conn
        end

      _ ->
        conn
    end
  end
end
