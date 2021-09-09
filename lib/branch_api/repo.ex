defmodule BranchApi.Repo do
  use Ecto.Repo,
    otp_app: :branch_api,
    adapter: Ecto.Adapters.Postgres
end
