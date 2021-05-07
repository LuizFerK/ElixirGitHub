ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Elixirgithub.Repo, :manual)

Mox.defmock(Elixirgithub.GetReposMock, for: Elixirgithub.GetReposBehaviour)
