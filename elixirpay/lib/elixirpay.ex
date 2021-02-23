defmodule Elixirpay do
  alias Elixirpay.Users.Create, as: UserCreate
  defdelegate create_user(params), to: UserCreate, as: :call
end
