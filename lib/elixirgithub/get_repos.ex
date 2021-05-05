defmodule Elixirgithub.GetRepos do
  use Tesla

  alias Elixirgithub.{Error, Repository}
  alias Tesla.Env

  @base_url "https://api.github.com/users/"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"User-Agent", "ElixirGitHub"}]

  def call(base_url \\ @base_url, user) do
    "#{base_url}#{user}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    repos =
      Enum.map(body, fn repo ->
        Repository.build(
          repo["id"],
          repo["name"],
          repo["description"],
          repo["html_url"],
          repo["stargazers_count"]
        )
      end)

    {:ok, repos}
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, Error.build(:not_found, "User not found")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
