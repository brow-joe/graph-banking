defmodule GraphBanking.Bank.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :current_balance, :decimal
    has_many :transactions, GraphBanking.Bank.Transaction
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:current_balance])
    |> validate_required([:current_balance])
    |> validate_number(:current_balance, greater_than: -1)
  end
end
