defmodule JJ.Repo do
  use Ecto.Repo,
    otp_app: :job_jawn_admin,
    adapter: Ecto.Adapters.Postgres
end
