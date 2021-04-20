defmodule Starconn.Repo.Migrations.CreateChatActions do
  use Ecto.Migration

  def change do
    create table(:chat_actions) do
      add :key, :string
      add :chat_user_id, references("chat_users", on_delete: :delete_all)

      timestamps()
    end

    create index(:chat_actions, [:key, :chat_user_id], unique: true)
  end
end
