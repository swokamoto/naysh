defmodule Strongbond.Repo do
  use Ecto.Repo,
    otp_app: :strongbond,
    adapter: Ecto.Adapters.Postgres
end
