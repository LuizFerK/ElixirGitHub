defmodule Elixirgithub.Repo do
  use Ecto.Repo,
    otp_app: :elixirgithub,
    adapter: Ecto.Adapters.Postgres
end
