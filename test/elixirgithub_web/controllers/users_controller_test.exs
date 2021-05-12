defmodule ElixirgithubWeb.UsersControllerTest do
  use ElixirgithubWeb.ConnCase, async: true

  alias Elixirgithub.User
  alias Elixirgithub.Users.Create
  alias ElixirgithubWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, create the user", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :create, %{"password" => "123456"}))
        |> json_response(:ok)

      assert %{"user" => %{"id" => _}, "token" => _} = response
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
      {:ok, %User{id: user_id} = user} = Create.call(%{"password" => "123456"})

      {:ok, user: user, user_id: user_id}
    end

    test "when the given user exists, delete the user", %{
      conn: conn,
      user: user,
      user_id: user_id
    } do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(Routes.users_path(conn, :delete, user_id))
        |> response(:no_content)

      assert response == ""
    end

    test "when the given user does not exists, returns an error", %{conn: conn, user: user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      response =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(Routes.users_path(conn, :delete, "7caa0719-c55e-45ca-9273-11fd664738c4"))
        |> json_response(:not_found)

      assert %{"error" => "User not found"} = response
    end

    test "when the user was not authenticated, returns an error", %{conn: conn} do
      response =
        conn
        |> delete(Routes.users_path(conn, :delete, "7caa0719-c55e-45ca-9273-11fd664738c4"))
        |> json_response(:unauthorized)

      assert %{"message" => "unauthenticated"} = response
    end
  end

  describe "sign_in/2" do
    setup do
      {:ok, %User{id: user_id}} = Create.call(%{"password" => "123456"})

      {:ok, id: user_id}
    end

    test "when the credentials are valid, authenticate the user", %{conn: conn, id: id} do
      params = %{"id" => id, "password" => "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:ok)

      assert %{"token" => _} = response
    end

    test "when the credentials are invalid, returns an error", %{conn: conn, id: id} do
      params = %{"id" => id, "password" => "wrong_password"}

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:unauthorized)

      assert %{"error" => "Please verify your credentials"} = response
    end

    test "when the user does not exists, returns an error", %{conn: conn} do
      params = %{"id" => "2baadea4-1d22-4d8c-9455-2ea5d692f930", "password" => "wrong_password"}

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:not_found)

      assert %{"error" => "User not found"} = response
    end
  end

  describe "update/2" do
    setup %{conn: conn} do
      {:ok, %User{id: user_id} = user} = Create.call(%{"password" => "123456"})

      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user_id: user_id}
    end

    test "when all params are valid, update the user", %{conn: conn, user_id: user_id} do
      response =
        conn
        |> put(Routes.users_path(conn, :update, user_id, %{"password" => "12345678"}))
        |> json_response(:ok)

      assert %{"user" => %{"id" => ^user_id}, "token" => _} = response
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
