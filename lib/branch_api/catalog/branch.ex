defmodule BranchApi.Catalog.Branch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "branches" do
    field :address, :string
    field :bank, :string
    field :name, :string
    field :number, :string
    field :phone, :string
    field :postal_code, :string
    field :location, Geo.PostGIS.Geometry
    field :distance, :float, virtual: true

    timestamps()
  end

  def changeset(branch, attrs) do
    branch
    |> cast(attrs, [:bank, :name, :phone, :address, :number, :postal_code, :location])
    |> validate_required([:bank, :name, :phone, :address, :number, :postal_code])
  end
end
