# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :migrator,
  ecto_repos: [Migrator.Repo]

# Configures the endpoint
config :migrator, MigratorWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4001],
  secret_key_base: "GPIwinKOC/zWxO29dBH6uaQYQxi6yz/uxwir0gEMQXLgf7bWWtiMPGGAQhuVXCJk",
  render_errors: [view: MigratorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Migrator.PubSub, adapter: Phoenix.PubSub.PG2]

config :migrator, MigratorWeb.Liveness,
  url: [host: "localhost"],
  http: [port: 4001],
  render_errors: [view: MigratorWeb.ErrorView, accepts: ~w(html json)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
