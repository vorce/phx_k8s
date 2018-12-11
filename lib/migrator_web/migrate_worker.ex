defmodule MigratorWeb.MigrateWorker do
  use GenServer

  require Logger

  @migrations_dir "#{:code.priv_dir(:migrator)}/repo/migrations"

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    state = nil
    Process.send_after(self(), :run_migrations, :timer.seconds(1))
    {:ok, state}
  end

  def handle_info(:run_migrations, _state) do
    Logger.info("Starting migrations..")

    :timer.sleep(:timer.seconds(10))

    result = Ecto.Migrator.run(Migrator.Repo, @migrations_dir, :up, all: true)
    Logger.info("Result of migrations: #{inspect(result)}")

    if is_list(result) do
      Logger.info("Migrations successful, starting all other endpoints")
      {:ok, _pid} = result = MigratorWeb.DynamicEndpoint.start_endpoint()
      {:stop, :normal, result}
    else
      Logger.error("Migrations failed! Will not start other endpoints.")
      {:stop, :shutdown, :error}
    end
  end
end
