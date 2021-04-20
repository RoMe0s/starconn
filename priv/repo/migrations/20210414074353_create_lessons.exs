defmodule Starconn.Repo.Migrations.CreateLessons do
  use Ecto.Migration

  def change do
    create table(:lessons) do
      add :teacher_id, references("teachers", on_delete: :delete_all)
      add :student_id, references("students", on_delete: :delete_all)
      add :class_id, references("classes", on_delete: :delete_all)
      add :date, :date
      add :from, :time
      add :to, :time
      add :payload, :text, null: true

      timestamps()
    end

  end
end
