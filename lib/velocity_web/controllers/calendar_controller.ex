defmodule VelocityWeb.CalendarController do
  use VelocityWeb, :controller

  alias Velocity.Calendar

  def sprint_calendar(conn, %{"start_date" => "Invalid date"}),
    do: render(conn, "calendar.json", %{calendar: []})

  def sprint_calendar(conn, %{"end_date" => "Invalid date"}),
    do: render(conn, "calendar.json", %{calendar: []})

  def sprint_calendar(conn, %{
        "team_key" => team_key,
        "start_date" => start_date,
        "end_date" => end_date
      }) do
    calendar =
      Calendar.build_sprint_calendar(
        team_key,
        Date.from_iso8601!(start_date),
        Date.from_iso8601!(end_date)
      )

    render(conn, "calendar.json", %{calendar: calendar})
  end

  def calendar_work_force(conn, %{"start_date" => "Invalid date"}),
    do: render(conn, "work_force.json", %{work_force: 0})

  def calendar_work_force(conn, %{"end_date" => "Invalid date"}),
    do: render(conn, "work_force.json", %{work_force: 0})

  def calendar_work_force(conn, %{
        "team_key" => team_key,
        "start_date" => start_date,
        "end_date" => end_date
      }) do
    work_force =
      Calendar.build_sprint_calendar(
        team_key,
        Date.from_iso8601!(start_date),
        Date.from_iso8601!(end_date)
      )
      |> Enum.map(&Map.get(&1, :availability))
      |> Enum.map(&Enum.count/1)
      |> Enum.sum()

    render(conn, "work_force.json", %{work_force: work_force})
  end
end
