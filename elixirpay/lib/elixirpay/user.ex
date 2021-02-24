defmodule Elixirpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  #Seta a chave primária no ID e UUID
  @primary_key {:id, :binary_id, autogenerate: true}

  #Define quais parametros são obrigatórios no request
  @required_params [:name, :age, :email, :password, :nickname]

  #Cria o schema (uma espécie da Model) de Usuário e linka com a tabela no banco
  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

  #Validação de Dados
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  #Faz o hash do campo "password" e coloca no campo "password_hash"
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  #Trata o erro retornando o changeset
  defp put_password_hash(changeset), do: changeset
end
