defmodule GraphBanking.AccountTest do
  use GraphBanking.ModelCase

  alias GraphBanking.Account

  @valid_attrs %{current_balance: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end
