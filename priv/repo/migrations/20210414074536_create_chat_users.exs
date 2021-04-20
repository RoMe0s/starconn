defmodule Starconn.Repo.Migrations.CreateChatUsers do
  use Ecto.Migration

  def change do
    create table(:chat_users) do
      add :chat_id, :integer
      add :user_id, references("users", on_delete: :delete_all), null: true
      add :username, :string
      add :name, :string

      timestamps()
    end

    create index(:chat_users, [:username], unique: true)
  end
end
