defmodule Elixirgithub.Users.UpdateTest do
  use Elixirgithub.DataCase, async: true

  alias Elixirgithub.{Error, User}
  alias Elixirgithub.Users.{Create, Update}

  describe "call/1" do
    setup do
      {:ok, %User{id: user_id}} = Create.call(%{"password" => "123456"})

      {:ok, user_id: user_id}
    end

    test "when all params are valid, update the user", %{user_id: user_id} do
      response = Update.call(%{"id" => user_id, "password" => "12345678"})

      assert {:ok, %User{id: _id, password: "12345678"}} = response
    end

    test "when the given user does not exists, returns an error" do
      response =
        Update.call(%{"id" => "e669e3db-e3c5-46c6-a985-ea7d76a50194", "password" => "12345678"})

      assert {:error, %Error{status: :not_found, result: "User not found"}} = response
    end

    test "when there are invalid params, returns an error", %{user_id: user_id} do
      response = Update.call(%{"id" => user_id, "password" => "12345"})

      assert {:error, %Error{status: :bad_request}} = response
    end
  end
end
