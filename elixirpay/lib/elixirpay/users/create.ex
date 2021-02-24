defmodule Elixirpay.Users.Create do
  alias Elixirpay.{Repo,User}

  #Cria o changeset baseado nos parametros vindo da rota e faz o insert no banco
  #OBS: Funcionamento parecido com um serviço
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
