defmodule ElixirgithubWeb.UsersView do
  use ElixirgithubWeb, :view

  alias Elixirgithub.User

  def render("user.json", %{user: %User{} = user, token: token}), do: %{user: user, token: token}

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
