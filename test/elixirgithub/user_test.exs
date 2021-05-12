defmodule Elixirgithub.UserTest do
  use Elixirgithub.DataCase, async: true

  alias Ecto.Changeset
  alias Elixirgithub.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      response = User.changeset(%{"password" => "123456"})

      assert %Changeset{data: %User{}, valid?: true} = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      response = User.changeset(%{"password" => "12345"})

      assert %{password: ["should be at least 6 character(s)"]} = errors_on(response)
    end
  end

  describe "changeset/2" do
    setup do
      user = %User{
        id: "f24967a9-8c5d-4dec-a4c0-6d0ba81d15b3",
        password: "123456",
        password_hash:
          "$pbkdf2-sha512$160000$Dp84zAkXBWrXEMrI4QXeRQ$AgYQHDrCO4N9lITES61MAOBz.Ns5OLbzSlH/BX8v5RCYY3/C7e/xt1eulf3hPTPDTZbhlMdJmuaNo.u1u5cdYA"
      }

      {:ok, user: user}
    end

    test "when all params are valid, returns a valid updated changeset", %{user: user} do
      response = User.changeset(user, %{"password" => "12345678"})

      assert %Changeset{data: %User{}, changes: %{password: "12345678"}, valid?: true} = response
    end

    test "when there are invalid params, returns an invalid changeset", %{user: user} do
      response = User.changeset(user, %{"password" => "12345"})

      assert %{password: ["should be at least 6 character(s)"]} = errors_on(response)
    end
  end
end
