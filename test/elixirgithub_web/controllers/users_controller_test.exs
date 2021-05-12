defmodule ElixirgithubWeb.UsersControllerTest do
  use ElixirgithubWeb.ConnCase, async: true

  alias Elixirgithub.User
  alias Elixirgithub.Users.Create

  describe "create/2" do
    test "when all params are valid, create the user", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :create, %{"password" => "123456"}))
        |> json_response(:ok)

      assert %{"id" => _} = response
    end

    test "when there is invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :create, %{"password" => "12345"}))
        |> json_response(:bad_request)

      assert %{"error" => %{"password" => ["should be at least 6 character(s)"]}} = response
    end
  end

  describe "delete/2" do
    setup do
      {:ok, %User{id: user_id}} = Create.call(%{"password" => "123456"})

      {:ok, user_id: user_id}
    end

    test "when the given user exists, delete the user", %{conn: conn, user_id: user_id} do
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, user_id))
        |> response(:no_content)

      assert response == ""
    end

    test "when the given user does not exists, returns an error", %{conn: conn} do
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, "7caa0719-c55e-45ca-9273-11fd664738c4"))
        |> json_response(:not_found)

      assert %{"error" => "User not found"} = response
    end
  end

  describe "update/2" do
    setup do
      {:ok, %User{id: user_id}} = Create.call(%{"password" => "123456"})

      {:ok, user_id: user_id}
    end

    test "when all params are valid, update the user", %{conn: conn, user_id: user_id} do
      response =
        conn
        |> put(Routes.users_path(conn, :update, user_id, %{"password" => "12345678"}))
        |> json_response(:ok)

      assert %{"id" => ^user_id} = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, user_id: user_id} do
      response =
        conn
        |> put(Routes.users_path(conn, :update, user_id, %{"password" => "12345"}))
        |> json_response(:bad_request)

      assert %{"error" => %{"password" => ["should be at least 6 character(s)"]}} = response
    end

    test "when the given user does not exists, returns an error", %{conn: conn} do
      response =
        conn
        |> put(
          Routes.users_path(conn, :update, "7caa0719-c55e-45ca-9273-11fd664738c4", %{
            "password" => "12345678"
          })
        )
        |> json_response(:not_found)

      assert %{"error" => "User not found"} = response
    end
  end
end
