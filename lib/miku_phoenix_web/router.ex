defmodule MikuPhoenixWeb.Router do
  use MikuPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", MikuPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api/random", MikuPhoenixWeb do
    pipe_through :api

    get "/", PageController, :api
  end

  # Other scopes may use custom stacks.
  # scope "/api", MikuPhoenixWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MikuPhoenixWeb.Telemetry
    end
  else
    scope "/", MikuPhoenixWeb do
      pipe_through :browser
      get "/dashboard", PageController, :fakedashboard
    end
  end
end
