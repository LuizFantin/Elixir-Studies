defmodule ElixirpayWeb.UsersView do
  #Encurta a chamada para apenas User
  alias Elixirpay.{User, Account}

  #Renderiza uma view em json para retornar o usuário criado
  def render("created.json", %{user: %User{account: %Account{id: account_id, balance: balance}, id: id, name: name, nickname: nickname}}) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
