defmodule ElixirpayWeb.AccountsView do
  #Encurta a chamada para apenas User
  alias Elixirpay.Account
  alias Elixirpay.Accounts.Transactions.Response, as: TransactionResponse

  #Renderiza uma view em json para retornar o usuário criado
  def render("update.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: id,
        balance: balance
      }
    }
  end
  #Renderiza uma view em json para retornar o usuário criado
  def render("transaction.json", %{transaction: %TransactionResponse{to_account: to_account, from_account: from_account}}) do
    %{
      message: "Transaction successfully",
      transaction: %{
        from_account: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to_account: %{
          id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
