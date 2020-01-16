defmodule GraphBanking.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :address, :string
      add :amount, :decimal
      add :when, :datetime
      add :transaction_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    create index(:transactions, [:transaction_id])

  end
end
