defmodule Migrator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Migrator.Repo,
      # Start the endpoint when the application starts
      MigratorWeb.Liveness,
      MigratorWeb.DynamicEndpoint,
      %{
        id: MigratorWeb.MigrateWorker,
        start: {MigratorWeb.MigrateWorker, :start_link, []},
        restart: :transient
      }
      #{MigratorWeb.MigrateWorker, [], restart: :transient}
      # Starts a worker by calling: Migrator.Worker.start_link(arg)
      # {Migrator.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Migrator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MigratorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
