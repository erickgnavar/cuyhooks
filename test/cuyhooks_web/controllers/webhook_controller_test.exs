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

  test "POST json content", %{conn: conn, hook: hook} do
    payload = %{
      "some" => "random",
      "data" => "test"
    }

    conn =
      conn
      |> put_req_header("content-type", "application/json")
      |> post("/hook/#{hook}", Jason.encode!(payload))

    assert text_response(conn, 200) =~ "ok"
  end

  test "POST json content with wrong content-type", %{conn: conn, hook: hook} do
    payload = %{
      "some" => "random",
      "data" => "test"
    }

    conn =
      conn
      |> put_req_header("content-type", "some random content-type")
      |> post("/hook/#{hook}", Jason.encode!(payload))

    assert text_response(conn, 200) =~ "ok"
  end

  test "POST /hook/create", %{conn: conn} do
    conn = post(conn, "/hook/create")
    assert redirected_to(conn) =~ "/hook/"
  end
end
