defmodule Starconn.Repo do
  use Ecto.Repo,
    otp_app: :starconn,
    adapter: Ecto.Adapters.Postgres
end
