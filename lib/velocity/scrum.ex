defmodule Velocity.Scrum do
  alias Velocity.Scrum.Jira
  alias Velocity.Team

  def get_sprints(team_key) do
    team = Team.get(team_key)

    sprints =
      team.board_id
      |> Jira.fetch_sprints()
      |> Enum.map(&map_sprint/1)
      |> Enum.filter(fn %{id: sprint_id} -> !Enum.member?(team.ignored_sprints, sprint_id) end)
      |> Enum.sort(fn %{startDate: startDateA}, %{startDate: startDateB} ->
        startDateB <= startDateA
      end)

    get_future_sprints(sprints) ++ get_past_sprints(sprints)
  end

  defp get_future_sprints(sprints),
    do:
      sprints
      |> Enum.filter(fn sprint -> sprint.state == "future" end)

  defp get_past_sprints(sprints),
    do:
      sprints
      |> Enum.filter(fn sprint -> sprint.state != "future" end)

  defp map_sprint(sprint),
    do: %{
      id: sprint["id"],
      name: sprint["name"],
      startDate: sprint["startDate"],
      endDate: sprint["endDate"],
      state: sprint["state"],
      velocity: nil
    }

  def get_sprint_velocity(sprint_id, team_key) do
    team = Team.get(team_key)

    Jira.fetch_sprint_stories(sprint_id)
    |> Enum.map(&Map.get(&1, "fields", %{}))
    |> Enum.filter(fn %{"status" => %{"name" => status}} -> status == team.done_story_status end)
    |> Enum.map(&Map.get(&1, "customfield_10002", 0))
    |> Enum.filter(&(&1 != nil))
    |> Enum.sum()
  end
end
