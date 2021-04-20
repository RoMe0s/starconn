defmodule Starconn.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :user_id, references("users", on_delete: :delete_all)
      add :organization_id, references("organizations", on_delete: :delete_all)

      timestamps()
    end

  end
end
