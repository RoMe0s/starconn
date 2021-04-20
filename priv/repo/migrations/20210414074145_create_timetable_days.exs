defmodule Starconn.Repo.Migrations.CreateTimetableDays do
  use Ecto.Migration

  def change do
    create table(:timetable_days) do
      add :timetable_id, references("timetables", on_delete: :delete_all)
      add :number, :integer

      timestamps()
    end

  end
end
