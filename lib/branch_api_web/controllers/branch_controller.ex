defmodule BranchApiWeb.BranchController do
  use BranchApiWeb, :controller

  alias BranchApi.Catalog
  alias BranchApi.Catalog.Branch

  action_fallback BranchApiWeb.FallbackController

  def index(conn, %{"latitude" => latitude, "longitude" => longitude}) do
    {longitude, _} = Float.parse(longitude)
    {latitude, _} = Float.parse(latitude)

    branches =
      Catalog.list_branches(%Geo.Point{
        coordinates: {longitude, latitude},
        srid: 4326
      })

    render(conn, "index.json", branches: branches)
  end

  def index(conn, _params) do
    branches = Catalog.list_branches()
    render(conn, "index.json", branches: branches)
  end

  def create(conn, %{"branch" => branch_params}) do
    with {:ok, %Branch{} = branch} <- Catalog.create_branch(branch_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.branch_path(conn, :show, branch))
      |> render("show.json", branch: branch)
    end
  end

  def show(conn, %{"id" => id}) do
    branch = Catalog.get_branch!(id)
    render(conn, "show.json", branch: branch)
  end

  def update(conn, %{"id" => id, "branch" => branch_params}) do
    branch = Catalog.get_branch!(id)

    with {:ok, %Branch{} = branch} <- Catalog.update_branch(branch, branch_params) do
      render(conn, "show.json", branch: branch)
    end
  end

  def delete(conn, %{"id" => id}) do
    branch = Catalog.get_branch!(id)

    with {:ok, %Branch{}} <- Catalog.delete_branch(branch) do
      send_resp(conn, :no_content, "")
    end
  end
end
