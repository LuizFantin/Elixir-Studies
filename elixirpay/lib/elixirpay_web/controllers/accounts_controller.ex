defmodule ElixirpayWeb.AccountsController do
  use ElixirpayWeb, :controller

  alias Elixirpay.Account

  #Define o fallback controller responsável por lidar com os erros
  action_fallback ElixirpayWeb.FallbackController

  def deposit(conn, params) do
    #Testa se o retorno da função é ok e account, se for, chama o escopo da função
    #Se tiver erro, chama o fallback controller
    with {:ok, %Account{} = account} <- Elixirpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> json(%{message: "Hello, Elixir! The new balance is #{account.balance}"})
      #|> render("update.json", account: account)
    end
  end
end
