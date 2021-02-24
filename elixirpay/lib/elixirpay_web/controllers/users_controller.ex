defmodule ElixirpayWeb.UsersController do
  use ElixirpayWeb, :controller

  alias Elixirpay.User

  #Define o fallback controller responsável por lidar com os erros
  action_fallback ElixirpayWeb.FallbackController

  def create(conn, params) do
    #Testa se o retorno da função é ok e user, se for, chama o escopo da função
    #Se tiver erro, chama o fallback controller
    with {:ok, %User{} = user} <- Elixirpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end
end
