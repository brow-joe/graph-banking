defmodule GraphBanking.Bank.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    belongs_to :target, GraphBanking.Bank.Account, foreign_key: :address
    field :amount, :decimal
    field :when, :naive_datetime
    belongs_to :source, GraphBanking.Bank.Account, foreign_key: :account_uuid
    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:address, :amount, :when, :account_uuid])
    |> validate_required([:address, :amount, :when])
    |> validate_number(:amount, greater_than: 0)
  end
end
