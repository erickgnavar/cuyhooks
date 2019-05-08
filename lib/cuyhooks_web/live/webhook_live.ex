defmodule CuyhooksWeb.WebhookLive do
  use Phoenix.LiveView
  alias CuyhooksWeb.Endpoint

  @topic "webhooks"

  def mount(_session, socket) do
    Endpoint.subscribe(@topic)
    {:ok, assign(socket, request: nil)}
  end

  def render(assigns) do
    ~L"""
    <%= unless is_nil(@request) do %>
      <h3>Info</h3>

      <table>
        <tr>
          <td>Host:</td>
          <td><%= @request.host %></td>
        </tr>
        <tr>
          <td>Method:</td>
          <td><%= @request.method %></td>
        </tr>
        <tr>
          <td>Querystring:</td>
          <td><%= @request.query_string %></td>
        </tr>
      </table>

      <h3>Headers</h3>

      <table>
        <%= for {key, value} <- @request.headers do %>
        <tr>
          <td><%= key %></td>
          <td><%= value %></td>
        </tr>
        <% end %>
      </table>

      <h3>Body</h3>
      <code>
      <%= to_json(@request.body) %>
      </code>
    <% else %>
      Waiting for a request...
    <% end %>
    """
  end

  @spec handle_info(Phoenix.Socket.Broadcast.t(), map) :: {:noreply, map}
  def handle_info(%{topic: @topic, event: "new_request", payload: payload}, socket) do
    {:noreply, assign(socket, request: payload)}
  end

  defp to_json(value), do: Jason.encode!(value)
end
