defmodule CuyhooksWeb.WebhookControllerTest do
  use CuyhooksWeb.ConnCase

  test "GET /webhook/:key", %{conn: conn} do
    conn = get(conn, "/webhook/id")
    assert text_response(conn, 200) =~ "ok"
  end

  test "POST /webhook/:key", %{conn: conn} do
    conn = post(conn, "/webhook/id")
    assert text_response(conn, 200) =~ "ok"
  end

  test "POST /webhook/create", %{conn: conn} do
    conn = post(conn, "/webhook/create")
    assert redirected_to(conn) =~ "/webhook/"
  end
end
