defmodule ElixirpayWeb.AccountsController do
  use ElixirpayWeb, :controller

  alias Elixirpay.Account
  alias Elixirpay.Accounts.Transactions.Response, as: TransactionResponse

  #Define o fallback controller responsável por lidar com os erros
  action_fallback ElixirpayWeb.FallbackController

  def deposit(conn, params) do
    #Testa se o retorno da função é ok e account, se for, chama o escopo da função
    #Se tiver erro, chama o fallback controller
    with {:ok, %Account{} = account} <- Elixirpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
      # |> json(%{message: "Hello, Elixir! The new balance is #{account.balance}"})
    end
  end

  def withdraw(conn, params) do
    #Testa se o retorno da função é ok e account, se for, chama o escopo da função
    #Se tiver erro, chama o fallback controller
    with {:ok, %Account{} = account} <- Elixirpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
      # |> json(%{message: "Hello, Elixir! The new balance is #{account.balance}"})
    end
  end

  def transaction(conn, params) do
    #Testa se o retorno da função é ok e TransactionResponse, se for, chama o escopo da função
    #Se tiver erro, chama o fallback controller
    with {:ok, %TransactionResponse{} = transaction} <- Elixirpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
