defmodule Elixirgithub do
  alias Elixirgithub.GetRepos

  defdelegate get_repos(user), to: GetRepos, as: :call
end
