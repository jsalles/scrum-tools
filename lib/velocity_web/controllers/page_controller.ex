defmodule VelocityWeb.PageController do
  use VelocityWeb, :controller

  def index(conn, _params) do
    # render(conn, "index.html")
    html(conn, File.read!("./priv/static/index.html"))
  end
end
