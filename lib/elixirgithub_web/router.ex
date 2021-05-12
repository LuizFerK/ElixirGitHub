defmodule ElixirgithubWeb.Router do
  use ElixirgithubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ElixirgithubWeb.Auth.Pipeline
    plug ElixirgithubWeb.Plugs.RefreshToken
  end

  scope "/api", ElixirgithubWeb do
    pipe_through [:api, :auth]

    get "/repos/:user", ReposController, :index
    resources "/users", UsersController, except: [:new, :edit, :create]
  end

  scope "/api", ElixirgithubWeb do
    pipe_through :api

    post "/users/signin", UsersController, :sign_in
    post "/users", UsersController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      # coveralls-ignore-start
      live_dashboard "/dashboard", metrics: ElixirgithubWeb.Telemetry
      # coveralls-ignore-stop
    end
  end
end
