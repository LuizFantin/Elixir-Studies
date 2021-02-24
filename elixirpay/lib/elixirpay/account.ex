defmodule Elixirpay.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Elixirpay.User

  #Seta a chave primária no ID e UUID
  @primary_key {:id, :binary_id, autogenerate: true}

  #Seta o tipo da chave estrangeira para o usuário
  @foreign_key_type :binary_id

  #Define quais parametros são obrigatórios no request
  @required_params [:balance, :user_id]

  #Cria o schema (uma espécie da Model) de Conta e linka com a tabela no banco
  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  #Validação de Dados
  def changeset(struct \\ %__MODULE__{}, params) do
    #struct se for update e MODULE(Vazia) se for criação
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
