defmodule Strongbond.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StrongbondWeb.Telemetry,
      Strongbond.Repo,
      {DNSCluster, query: Application.get_env(:strongbond, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Strongbond.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Strongbond.Finch},
      # Start a worker by calling: Strongbond.Worker.start_link(arg)
      # {Strongbond.Worker, arg},
      # Start to serve requests, typically the last entry
      StrongbondWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Strongbond.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StrongbondWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
