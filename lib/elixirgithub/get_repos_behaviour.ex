defmodule Elixirgithub.GetReposBehaviour do
  alias Elixirgithub.Error

  @callback call(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
