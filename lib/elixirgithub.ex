defmodule Elixirgithub do
  alias Elixirgithub.Users.{Create, Delete, Update}

  defdelegate get_repos(user),
    to: Application.fetch_env!(:elixirgithub, __MODULE__)[:get_repos_adapter],
    as: :call

  defdelegate create_user(params), to: Create, as: :call
  defdelegate delete_user(params), to: Delete, as: :call
  defdelegate update_user(params), to: Update, as: :call
end
