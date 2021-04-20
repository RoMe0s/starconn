defmodule Starconn.Chat.ChatAction.ChatAction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chat_actions" do
    field :key, Ecto.Enum, values: [
      :expect_name_option,
      :expect_name,
      :expect_teacher
    ]
    field :chat_user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(chat_action, attrs) do
    chat_action
    |> cast(attrs, [:key, :chat_user_id])
    |> validate_required([:key, :chat_user_id])
    |> unique_constraint([:key, :chat_user_id])
  end
end
