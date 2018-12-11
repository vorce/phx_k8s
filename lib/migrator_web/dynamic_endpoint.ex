defmodule MigratorWeb.DynamicEndpoint do
  use DynamicSupervisor

  require Logger

  @child_module MigratorWeb.Endpoint

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_endpoint() do
    spec = %{
      id: @child_module,
      restart: :transient,
      type: :supervisor,
      start: {
        @child_module,
        :start_link,
        []
      }
    }

    case DynamicSupervisor.start_child(__MODULE__, spec) do
      {:ok, _} = res ->
        res

      {:error, {:already_started, pid}} ->
        {:ok, pid}

      error ->
        error
    end
  end
end
