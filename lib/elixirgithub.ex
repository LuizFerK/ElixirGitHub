defmodule Elixirgithub do
  defdelegate get_repos(user),
    to: Application.fetch_env!(:elixirgithub, __MODULE__)[:get_repos_adapter],
    as: :call
end
