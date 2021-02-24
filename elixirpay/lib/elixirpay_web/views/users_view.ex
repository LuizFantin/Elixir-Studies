defmodule ElixirpayWeb.UsersView do
  #Encurta a chamada para apenas User
  alias Elixirpay.User

  #Renderiza uma view em json para retornar o usuário criado
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
