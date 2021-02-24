defmodule ElixirpayWeb.FallbackController do
  use ElixirpayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ElixirpayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
