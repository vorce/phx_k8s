defmodule Migrator.Repo do
  use Ecto.Repo,
    otp_app: :migrator,
    adapter: Ecto.Adapters.Postgres
end
