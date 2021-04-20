defmodule Starconn.Chat.ChatUser.ChatUserService do
  import Ecto.Query, only: [from: 2]

  alias Starconn.Repo
  alias Starconn.Chat.ChatUser.ChatUser

  def insert!(user_info) do
    %ChatUser{}
    |> ChatUser.changeset(user_info)
    |> Repo.insert!(on_conflict: {:replace_all_except, [:id, :username]},
      conflict_target: :username)
  end

  def update(%{id: _} = user_info) do
    %ChatUser{}
    |> ChatUser.changeset(user_info)
    |> Repo.update!()
  end

  def find_by_chat_id(chat_id) do
    Repo.get_by!(ChatUser, chat_id: chat_id)
  end

  def delete_by_username(username) do
    from(chat_user in ChatUser, where: chat_user.username == ^username) |> Repo.delete_all()
  end
end
