defmodule Elixirpay.Users.Create do
  alias Ecto.Multi
  alias Elixirpay.{Repo, User, Account}

  #Cria o changeset baseado nos parametros vindo da rota e faz o insert no banco
  #OBS: Funcionamento parecido com um serviço
  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(user, repo)
    end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
      preload_data(user, repo)
    end)
    |> run_transaction()

    ## Cria apenas o usuário
    # params
    # |> User.changeset()
    # |> Repo.insert()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}
    Account.changeset(params)
  end

  defp insert_account(user, repo) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp preload_data(user, repo) do
    {:ok, repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
