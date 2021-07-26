defmodule Velocity.Absence do
  alias Velocity.Absence.AbsenceIo
  alias Velocity.Calendar.DateHelper

  def get_vssp_members_and_absences(team_members, start_date, end_date),
    do:
      team_members
      |> Enum.map(&elem(&1, 1))
      |> AbsenceIo.fetch_absences(start_date, end_date)
      |> Enum.map(&map_absences/1)
      |> Enum.filter(fn %{reasonId: reasonId} -> reasonId != "5f4906a22b225e1598b78185" end)
      |> Enum.reduce(format_members_data(team_members), &add_members_absence/2)
      |> Map.to_list()
      |> Enum.map(&Kernel.elem(&1, 1))

  defp format_members_data(team_members),
    do:
      team_members
      |> Enum.map(&elem(&1, 1))
      |> AbsenceIo.fetch_members()
      |> Enum.reduce(%{}, fn member, acc ->
        with member_start_date <- team_member_start_date(team_members, member["email"]) do
          Map.put_new(acc, member["email"], %{
            firstName: member["firstName"],
            lastName: member["lastName"],
            email: member["email"],
            startDate: member_start_date,
            absences: []
          })
        end
      end)

  defp team_member_start_date(team_members, email),
    do:
      team_members
      |> Enum.find(fn {_, member_email, _} -> email == member_email end)
      |> elem(2)

  defp map_absences(
         %{
           "startDateTime" => startDateTime,
           "endDateTime" => endDateTime,
           "assignedTo" => %{
             "email" => email
           }
         } = absence
       ),
       do: %{
         startDateTime: startDateTime,
         endDateTime: endDateTime,
         email: email,
         reasonId: absence["reasonId"]
       }

  defp add_members_absence(absence, members),
    do:
      Map.put(members, absence.email, %{
        members[absence.email]
        | absences:
            DateHelper.create_date_time_range(
              NaiveDateTime.from_iso8601!(absence.startDateTime),
              NaiveDateTime.from_iso8601!(absence.endDateTime)
            ) ++
              members[absence.email].absences
      })
end
