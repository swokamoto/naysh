defmodule Naysh.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NayshWeb.Telemetry,
      Naysh.Repo,
      {DNSCluster, query: Application.get_env(:naysh, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Naysh.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Naysh.Finch},
      # Start a worker by calling: Naysh.Worker.start_link(arg)
      # {Naysh.Worker, arg},
      # Start to serve requests, typically the last entry
      NayshWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Naysh.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NayshWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
