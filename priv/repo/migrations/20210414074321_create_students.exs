defmodule Starconn.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :user_id, references("users", on_delete: :delete_all)
      add :class_id, references("classes", on_delete: :delete_all)
      add :price, :float

      timestamps()
    end

  end
end
