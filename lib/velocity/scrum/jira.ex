defmodule Velocity.Scrum.Jira do
  @base_url "https://jira.check24.de/rest/agile/1.0"

  defp fetch(url) do
    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           %HTTPoison.Request{
             method: :get,
             url: url,
             headers: [{:authorization, "Basic #{System.get_env("JIRA_AUTH_TOKEN")}"}],
             options: [ssl: [{:versions, [:"tlsv1.2"]}]]
           }
           |> HTTPoison.request() do
      Poison.decode!(body)
    end
  end

  defp join_pages(%{"isLast" => true, "values" => values}, _), do: values

  defp join_pages(
         %{
           "maxResults" => max_results,
           "startAt" => start_at,
           "isLast" => false,
           "values" => values
         },
         fetch_function
       ),
       do: values ++ fetch_function.(max_results + start_at)

  def fetch_sprints(board_id, start_at \\ 0) do
    fetch("#{@base_url}/board/#{board_id}/sprint?startAt=#{start_at}")
    |> join_pages(&fetch_sprints(board_id, &1))
  end

  def fetch_sprint_stories(sprint_id) do
    fetch(
      "#{@base_url}/sprint/#{sprint_id}/issue?fields=customfield_10002,status&jql=issueType%20in%20(Bug%2CStory%2CImprovement)"
    )
    |> Map.get("issues", [])
  end
end
