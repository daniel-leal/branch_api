defmodule BranchApi.Repo.Migrations.CreateBranches do
  use Ecto.Migration

  def change do
    create table(:branches) do
      add :bank, :string
      add :name, :string
      add :phone, :string
      add :address, :string
      add :number, :string
      add :postal_code, :string

      timestamps()
    end

  end
end
