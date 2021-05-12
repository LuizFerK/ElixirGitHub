defmodule ElixirgithubWeb.Auth.Guardian do
  use Guardian, otp_app: :elixirgithub

  alias Elixirgithub.{Error, Repo, User}

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> get_user()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- get_user(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {1, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  defp get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build(:not_found, "User not found")}
      %User{} = user -> {:ok, user}
    end
  end
end
