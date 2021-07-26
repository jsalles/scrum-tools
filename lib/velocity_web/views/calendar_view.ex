defmodule VelocityWeb.CalendarView do
  use VelocityWeb, :view
  alias VelocityWeb.CalendarView

  def render("calendar.json", %{calendar: calendar}) do
    %{data: render_many(calendar, CalendarView, "day.json", as: :day)}
  end

  def render("day.json", %{day: day}) do
    Map.take(day, [:date, :morning, :afternoon])
  end

  def render("workforce.json", %{workforce: work_force}) do
    %{data: work_force}
  end
end
