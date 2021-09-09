defmodule BranchApiWeb.BranchView do
  use BranchApiWeb, :view
  alias BranchApiWeb.BranchView

  def render("index.json", %{branches: branches}) do
    %{data: render_many(branches, BranchView, "branch.json")}
  end

  def render("show.json", %{branch: branch}) do
    %{data: render_one(branch, BranchView, "branch.json")}
  end

  def render("branch.json", %{branch: branch}) do
    %{
      id: branch.id,
      bank: branch.bank,
      name: branch.name,
      phone: branch.phone,
      address: branch.address,
      number: branch.number,
      postal_code: branch.postal_code,
      location: branch.location,
      distance: branch.distance
    }
  end
end
