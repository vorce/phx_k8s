defmodule MigratorWeb.PageController do
  use MigratorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
