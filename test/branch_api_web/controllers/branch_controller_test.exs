defmodule BranchApiWeb.BranchControllerTest do
  use BranchApiWeb.ConnCase

  alias BranchApi.Catalog
  alias BranchApi.Catalog.Branch

  @create_attrs %{
    address: "some address",
    bank: "some bank",
    location: "some location",
    name: "some name",
    number: "some number",
    phone: "some phone",
    postal_code: "some postal_code"
  }
  @update_attrs %{
    address: "some updated address",
    bank: "some updated bank",
    location: "some updated location",
    name: "some updated name",
    number: "some updated number",
    phone: "some updated phone",
    postal_code: "some updated postal_code"
  }
  @invalid_attrs %{address: nil, bank: nil, location: nil, name: nil, number: nil, phone: nil, postal_code: nil}

  def fixture(:branch) do
    {:ok, branch} = Catalog.create_branch(@create_attrs)
    branch
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all branches", %{conn: conn} do
      conn = get(conn, Routes.branch_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create branch" do
    test "renders branch when data is valid", %{conn: conn} do
      conn = post(conn, Routes.branch_path(conn, :create), branch: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.branch_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some address",
               "bank" => "some bank",
               "location" => "some location",
               "name" => "some name",
               "number" => "some number",
               "phone" => "some phone",
               "postal_code" => "some postal_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.branch_path(conn, :create), branch: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update branch" do
    setup [:create_branch]

    test "renders branch when data is valid", %{conn: conn, branch: %Branch{id: id} = branch} do
      conn = put(conn, Routes.branch_path(conn, :update, branch), branch: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.branch_path(conn, :show, id))

      assert %{
               "id" => id,
               "address" => "some updated address",
               "bank" => "some updated bank",
               "location" => "some updated location",
               "name" => "some updated name",
               "number" => "some updated number",
               "phone" => "some updated phone",
               "postal_code" => "some updated postal_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, branch: branch} do
      conn = put(conn, Routes.branch_path(conn, :update, branch), branch: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete branch" do
    setup [:create_branch]

    test "deletes chosen branch", %{conn: conn, branch: branch} do
      conn = delete(conn, Routes.branch_path(conn, :delete, branch))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.branch_path(conn, :show, branch))
      end
    end
  end

  defp create_branch(_) do
    branch = fixture(:branch)
    %{branch: branch}
  end
end
