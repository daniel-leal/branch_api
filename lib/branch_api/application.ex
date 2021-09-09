defmodule BranchApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BranchApi.Repo,
      # Start the Telemetry supervisor
      BranchApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BranchApi.PubSub},
      # Start the Endpoint (http/https)
      BranchApiWeb.Endpoint
      # Start a worker by calling: BranchApi.Worker.start_link(arg)
      # {BranchApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BranchApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BranchApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
