defmodule Starconn.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :slug, :string
      add :title, :string
      add :content, :text

      timestamps()
    end

    create index(:posts, [:slug], unique: true)
  end
end
