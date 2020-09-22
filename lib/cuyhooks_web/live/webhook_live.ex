defmodule CuyhooksWeb.WebhookLive do
  use Phoenix.LiveView
  alias CuyhooksWeb.Endpoint
  alias Cuyhooks.Requests

  @base_topic "webhooks"

  def mount(_params, %{"key" => key}, socket) do
    Endpoint.subscribe(@base_topic <> ":#{key}")
    {:ok, assign(socket, request: nil, key: key)}
  end

  def render(assigns) do
    CuyhooksWeb.WebhookView.render("request_live.html", assigns)
  end

  @spec handle_info(Phoenix.Socket.Broadcast.t(), map) :: {:noreply, map}
  def handle_info(%{topic: topic, event: "new_request", payload: payload}, socket) do
    if topic == "#{@base_topic}:#{socket.assigns.key}" do
      {:noreply, assign(socket, request: payload)}
    else
      {:noreply, socket}
    end
  end

  @spec handle_info(Phoenix.Socket.Broadcast.t(), map) :: {:noreply, map}
  def handle_info(%{topic: topic, event: "set_request", payload: %{"request_uid" => uid}}, socket) do
    if topic == "#{@base_topic}:#{socket.assigns.key}" do
      request = Requests.get_request_by_uid(uid)
      {:noreply, assign(socket, request: request)}
    else
      {:noreply, socket}
    end
  end
end
