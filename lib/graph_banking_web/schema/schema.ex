defmodule GraphBankingWeb.Schema.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  query do
    @desc "Get a list of accounts"
    field :accounts, list_of(:account) do
      resolve &GraphBankingWeb.Resolvers.Bank.retrieve_accounts/3
    end

    @desc "Get a account by its id"
    field :account, :account do
      arg :uuid, non_null(:string)
      resolve &GraphBankingWeb.Resolvers.Bank.retrieve_account/3
    end
  end

  mutation do
    field :open_account, :account do
      arg :balance, non_null(:decimal)
      resolve &GraphBankingWeb.Resolvers.Bank.create_account/2
    end

    field :transfer_money, :transaction do
      arg :sender, non_null(:string)
      arg :address, non_null(:string)
      arg :amount, non_null(:decimal)
      resolve &GraphBankingWeb.Resolvers.Bank.create_transaction/2
    end
  end

  object :account do
    field :uuid, non_null(:string)
    field :current_balance, non_null(:decimal)
    field :transactions, list_of(:transaction)
  end

  object :transaction do
    field :uuid, non_null(:string)
    field :address, non_null(:string)
    field :amount, non_null(:decimal)
    field :when, non_null(:string)
  end

end
