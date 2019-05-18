defmodule CuyhooksWeb.PageControllerTest do
  use CuyhooksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Create a webhook"
  end
end
