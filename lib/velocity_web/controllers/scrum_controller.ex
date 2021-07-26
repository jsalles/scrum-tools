defmodule VelocityWeb.ScrumController do
  use VelocityWeb, :controller

  alias Velocity.Scrum

  action_fallback VelocityWeb.FallbackController

  def index(conn, %{"team_key" => team_key}) do
    sprints = Scrum.get_sprints(team_key)

    render(conn, "index.json", %{sprints: sprints})
  end

  def sprint_velocity(conn, %{"team_key" => team_key, "sprint_id" => sprint_id}) do
    velocity = Scrum.get_sprint_velocity(sprint_id, team_key)

    render(conn, "sprint_velocity.json", %{velocity: velocity})
  end
end
