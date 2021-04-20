defmodule Starconn.Chat.ChatAction.ChatActionService do
  import Ecto.Query, only: [from: 2, last: 2]

  alias Starconn.Repo
  alias Starconn.Chat.ChatAction.ChatAction

  def new(key, chat_user_id) do
    %ChatAction{}
    |> ChatAction.changeset(%{key: key, chat_user_id: chat_user_id})
    |> Repo.insert!(on_conflict: :nothing, conflict_target: [:key, :chat_user_id])
  end

  def find_last(chat_user_id) do
    from(chat_action in ChatAction, where: chat_action.chat_user_id == ^chat_user_id)
    |> last(:inserted_at)
    |> Repo.one!()
  end
end
