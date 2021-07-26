defmodule Velocity.Calendar.Workday do
  @holidays [
    {~D[2020-01-01], :full_day_off},
    {~D[2020-01-06], :full_day_off},
    {~D[2020-04-10], :full_day_off},
    {~D[2020-04-13], :full_day_off},
    {~D[2020-05-01], :full_day_off},
    {~D[2020-05-21], :full_day_off},
    {~D[2020-06-01], :full_day_off},
    {~D[2020-06-11], :full_day_off},
    {~D[2020-08-15], :full_day_off},
    {~D[2020-10-03], :full_day_off},
    {~D[2020-11-01], :full_day_off},
    {~D[2020-12-24], :afternoon_off},
    {~D[2020-12-25], :full_day_off},
    {~D[2020-12-26], :full_day_off},
    {~D[2021-01-01], :full_day_off},
    {~D[2021-01-06], :full_day_off},
    {~D[2021-04-02], :full_day_off},
    {~D[2021-04-05], :full_day_off},
    {~D[2021-05-01], :full_day_off},
    {~D[2021-05-13], :full_day_off},
    {~D[2021-05-24], :full_day_off},
    {~D[2021-06-03], :full_day_off},
    {~D[2021-08-15], :full_day_off},
    {~D[2021-10-03], :full_day_off},
    {~D[2021-11-01], :full_day_off},
    {~D[2021-12-24], :afternoon_off},
    {~D[2021-12-25], :full_day_off},
    {~D[2021-12-26], :full_day_off}
  ]

  def get_workday_score(date) do
    cond do
      Date.day_of_week(date) >= 6 -> :full_day_off
      (score = get_holiday_score(date)) != nil -> score
      hackathon?(date) -> :afternoon_off
      true -> :workday
    end
  end

  defp get_holiday_score(date) do
    Enum.find_value(@holidays, fn {day, score} ->
      case day == date do
        true -> score
        false -> nil
      end
    end)
  end

  defp hackathon?(date) do
    first_hackathon = ~D[2020-01-10]

    case Date.compare(date, first_hackathon) do
      :lt -> false
      :eq -> true
      _ -> Date.add(date, -14) |> hackathon?()
    end
  end

  def inject_halfday_score({date, [morning, afternoon], workday_score}) do
    [morning_score, afternoon_score] =
      case workday_score do
        :workday -> [workable_halfday(morning, true), workable_halfday(afternoon, true)]
        :morning_off -> [workable_halfday(morning, false), workable_halfday(afternoon, true)]
        :afternoon_off -> [workable_halfday(morning, true), workable_halfday(afternoon, false)]
        :full_day_off -> [workable_halfday(morning, false), workable_halfday(afternoon, false)]
      end

    %{date: date, morning: morning_score, afternoon: afternoon_score}
  end

  defp workable_halfday({halfday_start, halfday_end}, workable),
    do: %{start_date_time: halfday_start, end_date_time: halfday_end, workable: workable}
end
