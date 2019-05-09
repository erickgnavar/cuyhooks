defmodule CuyhooksWeb.Router do
  use CuyhooksWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CuyhooksWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/webhook/create", WebhookController, :create
    get "/webhook/:key/live", WebhookController, :live
  end

  post "/webhook/:key", CuyhooksWeb.WebhookController, :index
  get "/webhook/:key", CuyhooksWeb.WebhookController, :index

  # Other scopes may use custom stacks.
  # scope "/api", CuyhooksWeb do
  #   pipe_through :api
  # end
end
