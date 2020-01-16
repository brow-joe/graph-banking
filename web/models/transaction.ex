defmodule GraphBanking.Transaction do
  use GraphBanking.Web, :model

  schema "transactions" do
    field :address, Ecto.UUID
    field :amount, :decimal
    field :when, Ecto.DateTime

    belongs_to :account, GraphBanking.Account, foreign_key: :account_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:address, :amount, :when, :account_id])
    |> validate_required([:address])
    |> validate_required([:amount])
    |> validate_required([:when])
    |> validate_number(:amount, greater_than: -1)
  end
end
