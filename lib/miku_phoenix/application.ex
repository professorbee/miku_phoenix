defmodule MikuPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MikuPhoenixWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MikuPhoenix.PubSub},
      # Start the Endpoint (http/https)
      MikuPhoenixWeb.Endpoint
      # Start a worker by calling: MikuPhoenix.Worker.start_link(arg)
      # {MikuPhoenix.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MikuPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MikuPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
