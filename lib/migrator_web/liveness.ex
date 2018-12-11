defmodule MigratorWeb.Liveness do
  use Phoenix.Endpoint, otp_app: :migrator

  plug Plug.RequestId
  plug Plug.Logger

  plug MigratorWeb.LivenessRouter
end
