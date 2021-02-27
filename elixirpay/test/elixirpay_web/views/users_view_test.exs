defmodule ElixirpayWeb.UsersViewTest do
  use ElixirpayWeb.ConnCase, async: true
  import Phoenix.View

  alias Elixirpay.{Account, User}
  alias ElixirpayWeb.UsersView

  test "renders created.json" do
    params = %{
      name: "LuizTeste",
      password: "123456",
      nickname: "LuizFan",
      email: "luiz@gmail.com",
      age: 21
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Elixirpay.create_user(params)

    response = render(UsersView, "created.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "LuizTeste",
        nickname: "LuizFan"
      }
    }

    assert expected_response == response
  end
end
