defmodule Starconn.Repo.Migrations.CreateTimetableHours do
  use Ecto.Migration

  def change do
    create table(:timetable_hours) do
      add :timetable_day_id, references("timetable_days", on_delete: :delete_all)
      add :from, :time
      add :to, :time

      timestamps()
    end

  end
end
