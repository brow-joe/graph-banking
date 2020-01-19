defmodule GraphBanking.BankTest do
  use GraphBanking.DataCase

  alias GraphBanking.Bank

  describe "accounts" do
    alias GraphBanking.Bank.Account

    @valid_attrs %{current_balance: "120.5"}
    @update_attrs %{current_balance: "456.7"}
    @invalid_attrs %{current_balance: nil}

    test "create_account/1 with valid data creates a account" do
      account = Bank.create_account(@valid_attrs)
      assert account.current_balance == Decimal.new("120.5")
    end
    
    test "update_account/2 with valid data updates the account" do
      account = Bank.create_account(@valid_attrs)
      assert {:ok, %Account{} = account} = Bank.update_account(account, @update_attrs)
      assert account.current_balance == Decimal.new("456.7")
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = Bank.create_account(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Bank.update_account(account, @invalid_attrs)
      assert account == Bank.get_account(account.uuid)
    end

    test "list_accounts/0 returns all accounts" do
      account = Bank.create_account(@valid_attrs)
      assert Bank.list_accounts() == [account]
    end
    
    test "get_account/1 returns the account with given uuid" do
      account = Bank.create_account(@valid_attrs)
      assert Bank.get_account(account.uuid) == account
    end

    test "change_account/1 returns a account changeset" do
      account = Bank.create_account(@valid_attrs)
      assert %Ecto.Changeset{} = Bank.change_account(account)
    end

    test "delete_account/1 deletes the account" do
      account = Bank.create_account(@valid_attrs)
      assert {:ok, %Account{}} = Bank.delete_account(account)
      assert Bank.get_account(account.uuid) == nil
    end
  end

  describe "transactions" do
    alias GraphBanking.Bank.Transaction

    @update_attrs %{"amount" => Decimal.new(200.5)}
    @invalid_attrs %{amount: nil}

    test "create_transaction/1 with valid data creates a transaction" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert transaction.amount == Decimal.new("100.5")
    end

    test "update_transaction/2 with valid data updates the transaction" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert {:ok, %Transaction{} = transaction} = Bank.update_transaction(transaction, @update_attrs)
      assert transaction.amount == Decimal.new("200.5")
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert {:error, %Ecto.Changeset{}} = Bank.update_transaction(transaction, @invalid_attrs)
      assert transaction == Bank.get_transaction!(transaction.uuid)
    end

    test "list_transactions/0 returns all transactions" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert Bank.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given uuid" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert Bank.get_transaction!(transaction.uuid) == transaction
    end

    test "change_transaction/1 returns a transaction changeset" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert %Ecto.Changeset{} = Bank.change_transaction(transaction)
    end

    test "delete_transaction/1 deletes the transaction" do
      source = Bank.create_account(%{current_balance: Decimal.new(500.5)})
      target = Bank.create_account(%{current_balance: Decimal.new(600.5)})
      params = %{"account_uuid" => source.uuid, "address" => target.uuid, "amount" => Decimal.new(100.5), "when" => DateTime.utc_now}
      transaction = Bank.create_transaction(params)
      assert {:ok, %Transaction{}} = Bank.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Bank.get_transaction!(transaction.uuid) end
    end
  end

end
