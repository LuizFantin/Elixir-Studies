defmodule Elixirpay.Numbers do

  #Abre o arquivo e realiza a soma
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  #Realiza efetivamente a soma dos números
  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",") #Transforma uma string "1,2,3,4,5" em um array "["1","2"...,"5"]
      |> Stream.map(fn number -> String.to_integer(number) end) #Transforma o array de string em inteiro
      |> Enum.sum() #Realiza a soma de um array de números
    {:ok, %{result: result}}
  end
  defp handle_file({:error, _reason}), do: {:error, %{message: "Aconteceu um erro!"}}

end
