defmodule ElixirgithubWeb.ReposView do
  use ElixirgithubWeb, :view

  alias Elixirgithub.Repository

  def render("repos.json", %{repos: [%Repository{} | _] = repos, token: token}) do
    %{token: token, repos: repos}
  end
end
