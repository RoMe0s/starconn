defmodule Starconn.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :organization_id, references("organizations", on_delete: :delete_all)
      add :teacher_id, references("teachers", on_delete: :delete_all)
      add :timetable_id, references("timetables", on_delete: :delete_all)
      add :key, :string
      add :name, :string

      timestamps()
    end

  end
end
