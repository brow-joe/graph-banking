defmodule GraphBanking.Account do
  use GraphBanking.Web, :model

  schema "accounts" do
    field :currentBalance, :decimal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:currentBalance])
    |> validate_required([:currentBalance])
  end
end
