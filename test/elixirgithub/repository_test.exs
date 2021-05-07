defmodule Elixirgithub.RepositoryTest do
  use Elixirgithub.DataCase, async: true

  alias Elixirgithub.Repository

  describe "build/5" do
    test "when all params are valid, returns a repository" do
      response = Repository.build(123_456, "RepoTest", "Description", "http://example.com", 5)

      expected_response = %Elixirgithub.Repository{
        description: "Description",
        html_url: "http://example.com",
        id: 123_456,
        name: "RepoTest",
        stargazers_count: 5
      }

      assert expected_response == response
    end
  end
end
