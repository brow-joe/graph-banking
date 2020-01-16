defmodule GraphBanking.Account do
  use GraphBanking.Web, :model

  schema "accounts" do
    field :uuid, :string
    field :balance, :decimal

    has_many :transactions, GraphBanking.Transaction

    timestamps()
  end

  @required_fields ~w(uuid, balance)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
  end
end
