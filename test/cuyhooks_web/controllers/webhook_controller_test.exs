defmodule CuyhooksWeb.WebhookControllerTest do
  use CuyhooksWeb.ConnCase

  setup do
    {:ok, hook: Ecto.UUID.generate()}
  end

  test "GET /hook/:key", %{conn: conn, hook: hook} do
    conn = get(conn, "/hook/#{hook}")
    assert text_response(conn, 200) =~ "ok"
  end

  test "POST /hook/:key", %{conn: conn, hook: hook} do
    conn = post(conn, "/hook/#{hook}")
    assert text_response(conn, 200) =~ "ok"
  end

  test "POST /hook/create", %{conn: conn} do
    conn = post(conn, "/hook/create")
    assert redirected_to(conn) =~ "/hook/"
  end
end
