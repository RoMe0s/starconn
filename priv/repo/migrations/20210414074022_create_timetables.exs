defmodule Starconn.Repo.Migrations.CreateTimetables do
  use Ecto.Migration

  def change do
    create table(:timetables) do
      add :name, :string
      add :default, :boolean, default: false, null: false

      timestamps()
    end

  end
end
