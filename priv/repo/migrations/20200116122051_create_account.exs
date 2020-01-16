defmodule GraphBanking.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :uuid, :string
      add :balance, :decimal

      timestamps()
    end

  end
end
