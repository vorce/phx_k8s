defmodule MigratorWeb.LivenessRouter do
  use MigratorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MigratorWeb do
    pipe_through :api

    get "/_liveness", LivenessController, :liveness
  end
end
