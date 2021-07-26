defmodule VelocityWeb.TeamView do
  use VelocityWeb, :view
  alias VelocityWeb.TeamView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json", as: :team)}
  end

  def render("team.json", %{team: team}) do
    team_members = render_many(team.members, TeamView, "member.json", as: :member)

    %{name: team.name, key: team.key, members: team_members}
  end

  def render("member.json", %{member: {name, email, start_date}}) do
    %{
      name: name,
      email: email,
      startDate: start_date
    }
  end
end
