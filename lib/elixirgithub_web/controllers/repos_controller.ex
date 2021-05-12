defmodule ElixirgithubWeb.ReposController do
  use ElixirgithubWeb, :controller

  alias Elixirgithub.Repository
  alias ElixirgithubWeb.FallbackController

  action_fallback FallbackController

  def index(conn, %{"user" => user}) do
    with {:ok, [%Repository{} | _] = repos} <- Elixirgithub.get_repos(user) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos, token: conn.private[:refreshed_token])
    end
  end
end
