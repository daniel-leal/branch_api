defmodule BranchApi.Repo.Migrations.BranchesAddLocationColumn do
  use Ecto.Migration

  def change do
    alter table("branches") do
      add :location, :geometry
    end
  end
end
