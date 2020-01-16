defmodule GraphBanking.Account do
  use GraphBanking.Web, :model

  schema "accounts" do
    field :current_balance, :decimal

    has_many :transactions, GraphBanking.Transaction

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:current_balance])
    |> validate_required([:current_balance])
  end
end
