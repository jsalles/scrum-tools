defmodule Velocity.Calendar.DateHelper do
  @spec create_date_time_range(NaiveDateTime.t(), NaiveDateTime.t()) :: [
          {NaiveDateTime.t(), NaiveDateTime.t()}
        ]
  def create_date_time_range(start_date_time, end_date_time),
    do: create_date_time_range(start_date_time, end_date_time, 12 * 3600)

  defp create_date_time_range(start_date_time, end_date_time, step) do
    stepped_date_time = NaiveDateTime.add(start_date_time, step, :second)

    case NaiveDateTime.compare(stepped_date_time, end_date_time) do
      :lt ->
        [
          {start_date_time, stepped_date_time}
          | create_date_time_range(
              stepped_date_time,
              end_date_time,
              step
            )
        ]

      _ ->
        [{start_date_time, end_date_time}]
    end
  end

  @spec create_date_range(Date.t(), Date.t()) :: [Date.t()]
  def create_date_range(start_date, end_date),
    do: Date.range(start_date, end_date) |> Enum.to_list()

  def to_halfday(%{date: date, workday_score: workday_score}) do
    {:ok, start_date_time} = {Date.to_erl(date), {0, 0, 0}} |> NaiveDateTime.from_erl({0, 3})
    end_date_time = NaiveDateTime.add(start_date_time, 24 * 3600, :second)

    range = create_date_time_range(start_date_time, end_date_time)
    {date, range, workday_score}
  end
end
