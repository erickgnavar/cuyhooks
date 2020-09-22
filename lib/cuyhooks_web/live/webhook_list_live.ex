defmodule CuyhooksWeb.WebhookListLive do
  use Phoenix.LiveView
  alias CuyhooksWeb.Endpoint
  alias Cuyhooks.Requests

  @base_topic "webhooks"

  def mount(_params, %{"key" => key}, socket) do
    Endpoint.subscribe(@base_topic <> ":#{key}")

    requests = Requests.list_requests_by_hook(key)
    {:ok, assign(socket, requests: requests, key: key)}
  end

  def render(assigns) do
    CuyhooksWeb.WebhookView.render("request_list_live.html", assigns)
  end

  @spec handle_info(Phoenix.Socket.Broadcast.t(), map) :: {:noreply, map}
  def handle_info(%{topic: topic, event: "new_request", payload: payload}, socket) do
    if topic == "#{@base_topic}:#{socket.assigns.key}" do
      {:noreply, assign(socket, requests: [payload | socket.assigns.requests])}
    else
      {:noreply, socket}
    end
  end

  def handle_event("set-request", %{"request-uid" => request_uid}, socket) do
    topic = "#{@base_topic}:#{socket.assigns.key}"
    # tell main live view to update the current request
    Endpoint.broadcast_from(self(), topic, "set_request", %{"request_uid" => request_uid})
    {:noreply, socket}
  end
end
