defmodule ElixirpayWeb.UsersView do
  alias Elixirpay.User

  def render("created.json", %{user: %User{id: id, name: name, nickname: nickname}}) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname
      }
    }
  end
end
