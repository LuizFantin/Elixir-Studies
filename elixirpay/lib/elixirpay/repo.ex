defmodule Elixirpay.Repo do
  use Ecto.Repo,
    otp_app: :elixirpay,
    adapter: Ecto.Adapters.Postgres
end
