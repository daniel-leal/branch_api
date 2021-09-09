defmodule BranchApi.CatalogTest do
  use BranchApi.DataCase

  alias BranchApi.Catalog

  describe "branches" do
    alias BranchApi.Catalog.Branch

    @valid_attrs %{address: "some address", bank: "some bank", name: "some name", number: "some number", phone: "some phone", postal_code: "some postal_code"}
    @update_attrs %{address: "some updated address", bank: "some updated bank", name: "some updated name", number: "some updated number", phone: "some updated phone", postal_code: "some updated postal_code"}
    @invalid_attrs %{address: nil, bank: nil, name: nil, number: nil, phone: nil, postal_code: nil}

    def branch_fixture(attrs \\ %{}) do
      {:ok, branch} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Catalog.create_branch()

      branch
    end

    test "list_branches/0 returns all branches" do
      branch = branch_fixture()
      assert Catalog.list_branches() == [branch]
    end

    test "get_branch!/1 returns the branch with given id" do
      branch = branch_fixture()
      assert Catalog.get_branch!(branch.id) == branch
    end

    test "create_branch/1 with valid data creates a branch" do
      assert {:ok, %Branch{} = branch} = Catalog.create_branch(@valid_attrs)
      assert branch.address == "some address"
      assert branch.bank == "some bank"
      assert branch.name == "some name"
      assert branch.number == "some number"
      assert branch.phone == "some phone"
      assert branch.postal_code == "some postal_code"
    end

    test "create_branch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_branch(@invalid_attrs)
    end

    test "update_branch/2 with valid data updates the branch" do
      branch = branch_fixture()
      assert {:ok, %Branch{} = branch} = Catalog.update_branch(branch, @update_attrs)
      assert branch.address == "some updated address"
      assert branch.bank == "some updated bank"
      assert branch.name == "some updated name"
      assert branch.number == "some updated number"
      assert branch.phone == "some updated phone"
      assert branch.postal_code == "some updated postal_code"
    end

    test "update_branch/2 with invalid data returns error changeset" do
      branch = branch_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_branch(branch, @invalid_attrs)
      assert branch == Catalog.get_branch!(branch.id)
    end

    test "delete_branch/1 deletes the branch" do
      branch = branch_fixture()
      assert {:ok, %Branch{}} = Catalog.delete_branch(branch)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_branch!(branch.id) end
    end

    test "change_branch/1 returns a branch changeset" do
      branch = branch_fixture()
      assert %Ecto.Changeset{} = Catalog.change_branch(branch)
    end
  end
end
