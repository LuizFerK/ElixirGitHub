defmodule ElixirgithubWeb.FallbackController do
  use ElixirgithubWeb, :controller

  alias Elixirgithub.Error
  alias ElixirgithubWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
