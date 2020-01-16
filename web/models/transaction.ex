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
    |> cast(params, [:address, :amount, :when])
    |> validate_required([:address, :amount, :when])
  end
end
