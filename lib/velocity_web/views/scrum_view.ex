defmodule VelocityWeb.ScrumView do
  use VelocityWeb, :view
  alias VelocityWeb.ScrumView

  def render("index.json", %{sprints: sprints}) do
    %{data: render_many(sprints, ScrumView, "sprint.json", as: :sprint)}
  end

  def render("sprint.json", %{sprint: sprint}) do
    %{
      id: sprint.id,
      name: sprint.name,
      startDate: sprint.startDate,
      endDate: sprint.endDate,
      state: sprint.state,
      velocity: sprint.velocity
    }
  end

  def render("sprint_velocity.json", %{velocity: velocity}) do
    %{data: velocity}
  end
end
