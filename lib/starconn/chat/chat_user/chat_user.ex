defmodule Starconn.Chat.ChatUser.ChatUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_users" do
    field :username, :string
    field :chat_id, :integer
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(chat_user, attrs) do
    chat_user
    |> cast(attrs, [:chat_id, :user_id, :username, :name])
    |> validate_required([:chat_id, :username, :name])
    |> unique_constraint(:username)
  end
end
