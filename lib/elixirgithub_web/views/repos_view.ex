defmodule ElixirgithubWeb.ReposView do
  use ElixirgithubWeb, :view

  alias Elixirgithub.Repository

  def render("repos.json", %{repos: [%Repository{} | _] = repos}), do: repos
end
