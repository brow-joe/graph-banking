defmodule GraphBanking.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :balance, :decimal

      timestamps()
    end

  end
end
