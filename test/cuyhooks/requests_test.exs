defmodule Cuyhooks.RequestsTest do
  use Cuyhooks.DataCase

  alias Cuyhooks.Requests

  describe "requests" do
    alias Cuyhooks.Requests.Request

    @valid_attrs %{
      body: "some body",
      headers: %{},
      hook: "7488a646-e31f-11e4-aace-600308960662",
      host: "some host",
      method: "some method",
      querystring: "some querystring"
    }
    @update_attrs %{
      body: "some updated body",
      headers: %{},
      hook: "7488a646-e31f-11e4-aace-600308960668",
      host: "some updated host",
      method: "some updated method",
      querystring: "some updated querystring"
    }
    @invalid_attrs %{
      body: nil,
      headers: nil,
      hook: nil,
      host: nil,
      method: nil,
      querystring: nil,
      uid: nil
    }

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Requests.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Requests.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Requests.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Requests.create_request(@valid_attrs)
      assert request.body == "some body"
      assert request.headers == %{}
      assert request.hook == "7488a646-e31f-11e4-aace-600308960662"
      assert request.host == "some host"
      assert request.method == "some method"
      assert request.querystring == "some querystring"
      refute is_nil(request.uid)
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Requests.update_request(request, @update_attrs)
      assert request.body == "some updated body"
      assert request.headers == %{}
      assert request.hook == "7488a646-e31f-11e4-aace-600308960668"
      assert request.host == "some updated host"
      assert request.method == "some updated method"
      assert request.querystring == "some updated querystring"
      refute is_nil(request.uid)
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_request(request, @invalid_attrs)
      assert request == Requests.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Requests.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Requests.change_request(request)
    end
  end
end
