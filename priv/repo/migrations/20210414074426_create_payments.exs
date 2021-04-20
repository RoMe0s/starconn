defmodule Starconn.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :lesson_id, references("lessons", on_delete: :delete_all)
      add :amount, :float
      add :note, :text, null: true

      timestamps()
    end

  end
end
