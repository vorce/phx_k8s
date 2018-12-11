defmodule MigratorWeb.Router do
  use MigratorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MigratorWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/_readiness", MigratorWeb do
    pipe_through :api

    get "/", LivenessController, :liveness
  end
end
