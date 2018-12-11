defmodule MigratorWeb.LivenessController do
  use MigratorWeb, :controller

  def liveness(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "OK")
  end
end
