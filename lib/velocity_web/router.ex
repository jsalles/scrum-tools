defmodule VelocityWeb.Router do
  use VelocityWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VelocityWeb do
    pipe_through :api
    resources "/team", TeamController, only: [:index]
    resources "/scrum/:team_key", ScrumController, only: [:index]
    get "/scrum/:team_key/sprints/:sprint_id/velocity", ScrumController, :sprint_velocity
    get "/calendar/:team_key/:start_date/:end_date", CalendarController, :sprint_calendar

    get "/calendar/:team_key/:start_date/:end_date/work_force",
        CalendarController,
        :calendar_work_force
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", VelocityWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :index
  end
end
