defmodule ElixirpayWeb.WelcomeController do
  use ElixirpayWeb, :controller

  alias Elixirpay.Numbers

  #Passa o nome do arquivo para a função soma e depois retorna o resultado
  def index(conn, %{"filename" => filename}) do
    filename
    |> Numbers.sum_from_file()
    |> handle_response(conn)
  end

  #Função que trata a situação do sucesso
  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok) #Seta o status http para 200
    |> json(%{message: "Hello, Elixir! The result is #{result}"})
  end

  #Função que trata a situação de erro
  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request) #Seta o status http da connection em Bad Request
    |> json(reason)
  end
end
