defmodule VelocityWeb.TeamController do
  use VelocityWeb, :controller

  def index(conn, _params) do
    teams = Velocity.Team.list()

    render(conn, "index.json", %{teams: teams})
  end
end
