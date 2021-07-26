defmodule Velocity.Absence.AbsenceIo do
  @base_url "https://app.absence.io/api/v2"

  defp fetch(url, payload) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           %HTTPoison.Request{
             method: :post,
             url: url,
             headers: [
               {"content-type", "application/json"},
               {:authorization,
                Hawk.header(
                  url,
                  "POST",
                  %Hawk.Models.Credentials{
                    algorithm: :sha256,
                    id: System.get_env("ABSENCE_IO_ID"),
                    key: System.get_env("ABSENCE_IO_KEY")
                  },
                  Poison.encode!(payload)
                )}
             ],
             body: Poison.encode!(payload),
             options: [ssl: [{:versions, [:"tlsv1.2"]}]]
           }
           |> HTTPoison.request() do
      Poison.decode!(body)
    end
  end

  def fetch_members(emails) do
    payload = %{
      limit: 1000,
      filter: %{
        email: %{"$in": emails}
      }
    }

    fetch("#{@base_url}/users", payload)
    |> Map.get("data")
  end

  def fetch_absences(emails, start_date, end_date) do
    payload = %{
      limit: 1000,
      filter: %{
        "assignedTo:user._id": %{email: %{"$in": emails}},
        start: %{"$lte": end_date},
        end: %{"$gte": start_date}
      },
      relations: ["assignedToId"]
    }

    fetch("#{@base_url}/absences", payload)
    |> Map.get("data")
  end
end
