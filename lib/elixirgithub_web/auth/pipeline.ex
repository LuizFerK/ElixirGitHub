defmodule ElixirgithubWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :elixirgithub

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
