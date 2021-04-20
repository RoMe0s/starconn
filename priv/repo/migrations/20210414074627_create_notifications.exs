defmodule Starconn.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :key, :string
      add :payload, :text
      add :sent_at, :naive_datetime, null: true

      timestamps()
    end

  end
end
