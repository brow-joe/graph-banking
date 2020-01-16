defmodule GraphBanking.Transaction do
  use GraphBanking.Web, :model

  schema "transactions" do
    field :uuid, :string
    field :address, :string
    field :amount, :decimal
    field :when, Ecto.DateTime
    belongs_to :transaction, GraphBanking.Transaction, foreign_key: :account_id

    timestamps()
  end

  @required_fields ~w(uuid address amount when account_id)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
  end
end
