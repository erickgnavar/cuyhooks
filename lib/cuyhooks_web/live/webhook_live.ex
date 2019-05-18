defmodule CuyhooksWeb.WebhookLive do
  use Phoenix.LiveView
  alias CuyhooksWeb.Endpoint

  @base_topic "webhooks"

  def mount(session, socket) do
    key = Map.get(session, "key")
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
end
