defmodule VelocityWeb.AbsenceView do
  use VelocityWeb, :view
  alias VelocityWeb.AbsenceView

  def render("index.json", %{members: members}) do
    %{data: render_many(members, AbsenceView, "member.json", as: :member)}
  end

  def render("show.json", %{member: member}) do
    %{data: render_one(member, AbsenceView, "member.json")}
  end

  def render("member.json", %{member: member}) do
    %{
      firstName: member.firstName,
      lastName: member.lastName,
      email: member.email,
      absences: render_many(member.absences, AbsenceView, "absence.json", as: :absence)
    }
  end

  def render("absence.json", %{absence: absence}) do
    %{startDateTime: absence.startDateTime, endDateTime: absence.endDateTime}
  end
end
