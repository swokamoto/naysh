defmodule Naysh.Repo do
  use Ecto.Repo,
    otp_app: :naysh,
    adapter: Ecto.Adapters.Postgres
end
