defmodule ElixirgithubWeb.Plugs.RefreshToken do
  import Plug.Conn

  alias ElixirgithubWeb.Auth.Guardian
  alias Plug.Conn

  # coveralls-ignore-start
  def init(options), do: options
  # coveralls-ignore-stop

  def call(%Conn{} = conn, _opts) do
    ["Bearer " <> token] = get_req_header(conn, "authorization")

    {:ok, _old_stuff, {new_token, _new_claims}} = Guardian.refresh(token, ttl: {1, :minute})

    put_private(conn, :refreshed_token, new_token)
  end
end
