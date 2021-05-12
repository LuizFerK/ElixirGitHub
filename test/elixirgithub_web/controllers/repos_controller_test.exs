defmodule ElixirgithubWeb.ReposControllerTest do
  use ElixirgithubWeb.ConnCase, async: true
  import Mox

  alias Elixirgithub.{Error, GetReposMock, Repository, User}
  alias Elixirgithub.Users.Create
  alias ElixirgithubWeb.Auth.Guardian

  describe "index/1" do
    setup %{conn: conn} do
      {:ok, %User{} = user} = Create.call(%{"password" => "123456"})

      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "when the user exists, return their repositories", %{conn: conn} do
      user = "LuizFerK"

      body = [
        %Repository{
          id: 277_408_587,
          name: "AboutMe",
          html_url: "https://github.com/LuizFerK/AboutMe",
          description: nil,
          stargazers_count: 0
        },
        %Repository{
          id: 250_084_405,
          name: "BeTheHero",
          html_url: "https://github.com/LuizFerK/BeTheHero",
          description:
            "A JavaScript Node.js, React.js and ReactNative application that helps NGOs to find people to make donations in cases of need.",
          stargazers_count: 1
        }
      ]

      expect(GetReposMock, :call, fn _repos -> {:ok, body} end)

      response =
        conn
        |> get(Routes.repos_path(conn, :index, user))
        |> json_response(:ok)

      assert %{
               "token" => _,
               "repos" => [
                 %{
                   "description" => nil,
                   "html_url" => "https://github.com/LuizFerK/AboutMe",
                   "id" => 277_408_587,
                   "name" => "AboutMe",
                   "stargazers_count" => 0
                 },
                 %{
                   "description" =>
                     "A JavaScript Node.js, React.js and ReactNative application that helps NGOs to find people to make donations in cases of need.",
                   "html_url" => "https://github.com/LuizFerK/BeTheHero",
                   "id" => 250_084_405,
                   "name" => "BeTheHero",
                   "stargazers_count" => 1
                 }
               ]
             } = response
    end

    test "when the user does not exists, returns an error", %{conn: conn} do
      user = "no_existent_user_for_tests"

      body = %{
        message: "Not Found",
        documentation_url:
          "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
      }

      expect(GetReposMock, :call, fn _repos -> {:error, Error.build(:not_found, body)} end)

      response =
        conn
        |> get(Routes.repos_path(conn, :index, user))
        |> json_response(:not_found)

      expected_response = %{
        "error" => %{
          "documentation_url" =>
            "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user",
          "message" => "Not Found"
        }
      }

      assert response == expected_response
    end
  end
end
