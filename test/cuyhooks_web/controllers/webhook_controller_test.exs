defmodule CuyhooksWeb.WebhookControllerTest do
  use CuyhooksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/webhook")
    assert text_response(conn, 200) =~ "ok"
  end

  test "POST /", %{conn: conn} do
    conn = post(conn, "/webhook")
    assert text_response(conn, 200) =~ "ok"
  end
end
