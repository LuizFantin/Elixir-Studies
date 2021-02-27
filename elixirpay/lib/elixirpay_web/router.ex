defmodule ElixirpayWeb.Router do
  use ElixirpayWeb, :router

  import Plug.BasicAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :basic_auth, Application.compile_env(:elixirpay, :basic_auth)
  end

  scope "/api", ElixirpayWeb do
    pipe_through :api

    #Rota get para abrir um arquivo csv com numeros e somá-los
    get "/:filename", WelcomeController, :index

    #Rota post para criar um usuário
    post "/users", UsersController, :create
  end

  scope "/api", ElixirpayWeb do
    pipe_through [:api, :auth]

    #Rota post para depositar numa conta
    post "/accounts/:id/deposit", AccountsController, :deposit

    #Rota post para sacar de uma conta
    post "/accounts/:id/withdraw", AccountsController, :withdraw

    #Rota post para transação entre contas
    post "/accounts/transaction", AccountsController, :transaction
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ElixirpayWeb.Telemetry
    end
  end
end
