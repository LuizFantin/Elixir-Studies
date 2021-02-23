defmodule Elixirpay.Users.Create do
  alias Elixirpay.{Repo,User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
