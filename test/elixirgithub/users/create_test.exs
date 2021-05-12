defmodule Elixirgithub.Users.CreateTest do
  use Elixirgithub.DataCase, async: true

  alias Elixirgithub.{Error, User}
  alias Elixirgithub.Users.Create

  describe "call/1" do
    test "when all params are valid, create the user" do
      response = Create.call(%{"password" => "123456"})

      assert {:ok, %User{id: _id, password: "123456"}} = response
    end

    test "when there are invalid params, returns an error" do
      response = Create.call(%{"password" => "12345"})

      assert {:error, %Error{status: :bad_request}} = response
    end
  end
end
