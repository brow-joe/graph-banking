defmodule GraphBankingWeb.Resolvers.Bank do
  alias GraphBanking.Bank
  alias GraphBanking.Bank.Account
  alias GraphBanking.Bank.Transaction

  def retrieve_accounts(_, _, _) do
    {:ok, Bank.list_accounts()}
  end

  def retrieve_account(_, %{uuid: uuid}, _) do
    account = Bank.get_account(uuid)
    cond do
      account == nil -> 
        {:error, "Account does not exist!"}
      true -> 
        {:ok, account}
    end
  end

  def create_account(args, _info) do
    current_balance = args.balance
    cond do
      Decimal.compare(current_balance, 0) == Decimal.new(-1) ->
        {:error, "Balance cannot be negative!"}
      true ->
        account = %{"current_balance" => current_balance}
        {:ok, Bank.create_account(account)}
    end
  end

  def create_transaction(args, _info) do
    source_id = args.sender
    target_id = args.address
    amount = args.amount
    
    source = Bank.get_account(source_id)
    target = Bank.get_account(target_id)

    cond do
      source == nil ->
        {:error, "Sender account does not exist!"}
      target == nil ->
        {:error, "Address account does not exist!"}
      source_id == target_id ->
        {:error, "The sender cannot be the same as the address!"}
      Decimal.compare(amount, 1) == Decimal.new(-1) ->
        {:error, "Amount must be greater than zero!"}
      amount > source.current_balance ->
        {:error, "Sender does not have enough balance for this operation!"}
      true ->
        transaction = %{"account_uuid" => source_id, "address" => target_id, "amount" => amount, "when" => DateTime.utc_now}
        {:ok, Bank.create_transaction(transaction)}
    end
  end

end
