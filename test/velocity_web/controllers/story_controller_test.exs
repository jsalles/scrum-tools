defmodule VelocityWeb.StoryControllerTest do
  # use VelocityWeb.ConnCase

  # alias Velocity.Scrum
  # alias Velocity.Scrum.Story

  # @create_attrs %{}
  # @update_attrs %{}
  # @invalid_attrs %{}

  # def fixture(:story) do
  #   {:ok, story} = Scrum.create_story(@create_attrs)
  #   story
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all stories", %{conn: conn} do
  #     conn = get(conn, Routes.story_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create story" do
  #   test "renders story when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.story_path(conn, :create), story: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.story_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.story_path(conn, :create), story: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update story" do
  #   setup [:create_story]

  #   test "renders story when data is valid", %{conn: conn, story: %Story{id: id} = story} do
  #     conn = put(conn, Routes.story_path(conn, :update, story), story: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.story_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, story: story} do
  #     conn = put(conn, Routes.story_path(conn, :update, story), story: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete story" do
  #   setup [:create_story]

  #   test "deletes chosen story", %{conn: conn, story: story} do
  #     conn = delete(conn, Routes.story_path(conn, :delete, story))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.story_path(conn, :show, story))
  #     end
  #   end
  # end

  # defp create_story(_) do
  #   story = fixture(:story)
  #   {:ok, story: story}
  # end
end
