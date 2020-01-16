defmodule GraphBanking.Account do
  use GraphBanking.Web, :model

  schema "accounts" do
    field :balance, :decimal

    has_many :comments, GraphBanking.Transaction

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:balance])
    |> validate_required([:balance])
  end
end
