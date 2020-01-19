defmodule GraphBanking.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :address, references(:accounts, column: :uuid, on_delete: :nothing, type: :binary_id)
      add :amount, :decimal
      add :when, :naive_datetime
      add :account_uuid, references(:accounts, column: :uuid, on_delete: :nothing, type: :binary_id)
      timestamps()
    end

    create index(:transactions, [:account_uuid])
    create index(:transactions, [:address])
  end
end
