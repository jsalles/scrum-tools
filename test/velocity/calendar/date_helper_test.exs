defmodule Velocity.Calendar.DateHelperTest do
  use ExUnit.Case, async: true
  doctest Velocity.Calendar.DateHelper

  alias Velocity.Calendar.DateHelper

  describe "create_date_time_range" do
    test "returns list of 12 hour steps between dates" do
      start_date_time = ~N[2001-01-01 00:00:00.000]
      end_date_time = ~N[2001-01-02 23:59:59.000]
      date_range = DateHelper.create_date_time_range(start_date_time, end_date_time)

      assert date_range == [
               {~N[2001-01-01 00:00:00.000], ~N[2001-01-01 12:00:00.000]},
               {~N[2001-01-01 12:00:00.000], ~N[2001-01-02 00:00:00.000]},
               {~N[2001-01-02 00:00:00.000], ~N[2001-01-02 12:00:00.000]},
               {~N[2001-01-02 12:00:00.000], ~N[2001-01-02 23:59:59.000]}
             ]
    end
  end
end
