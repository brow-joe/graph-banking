defmodule GraphBanking.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :uuid, :string
      add :address, :string
      add :amount, :decimal
      add :when, :datetime
      add :transaction_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end
    create index(:transactions, [:transaction_id])

  end
end
