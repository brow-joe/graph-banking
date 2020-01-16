defmodule GraphBanking.Account do
  use GraphBanking.Web, :model

  schema "accounts" do
    field :uuid, :string
    field :balance, :decimal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uuid, :balance])
    |> validate_required([:uuid, :balance])
  end
end
