defmodule Velocity.Calendar do
  alias Velocity.Calendar.DateHelper
  alias Velocity.Calendar.Workday
  alias Velocity.Absence
  alias Velocity.Team

  def build_sprint_calendar(team_key, start_date, end_date) do
    members =
      Team.get(team_key)
      |> Map.get(:members, [])
      |> Absence.get_vssp_members_and_absences(start_date, end_date)

    DateHelper.create_date_range(start_date, end_date)
    |> Enum.map(fn date -> %{date: date, workday_score: Workday.get_workday_score(date)} end)
    |> Enum.map(&DateHelper.to_halfday/1)
    |> Enum.map(&Workday.inject_halfday_score/1)
    |> List.flatten()
    |> Enum.map(&inject_availability(&1, members))
  end

  defp inject_availability(%{morning: morning, afternoon: afternoon} = day, members),
    do: %{
      day
      | morning: inject_halfday_availability(morning, members),
        afternoon: inject_halfday_availability(afternoon, members)
    }

  defp inject_halfday_availability(%{workable: false} = day, _members),
    do: Map.put_new(day, :availability, [])

  defp inject_halfday_availability(
         %{start_date_time: start_date_time, end_date_time: end_date_time} = day,
         members
       ) do
    available_members =
      Enum.filter(members, fn %{absences: absences, startDate: member_start_date_time} ->
        !Enum.member?(absences, {start_date_time, end_date_time}) &&
          NaiveDateTime.compare(member_start_date_time, start_date_time) != :gt
      end)
      |> Enum.map(fn %{firstName: firstName} -> firstName end)

    Map.put_new(day, :availability, available_members)
  end
end
