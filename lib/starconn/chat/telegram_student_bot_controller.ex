defmodule Starconn.Chat.TelegramStudentBotController do

  alias Starconn.Chat.TelegramStudentBot, as: Bot

  def action(%{"message" => %{"text" => "/start"} = message}) do
    Bot.join(%{
      chat_id: message["chat"]["id"],
      username: message["from"]["username"],
      name: message["from"]["first_name"] <> " " <> message["from"]["last_name"]
    })
  end

  def action(%{"message" => %{"text" => message, "chat" => %{"id" => chat_id}}}) do
    Bot.receive(%{chat_id: chat_id, message: message})
  end

  def action(%{"my_chat_member" => %{"new_chat_member" => %{"status" => "kicked"}, "from" => %{"username" => username}}}) do
    Bot.leave(username)
  end

  def action(%{"my_chat_member" => %{"new_chat_member" => %{"status" => "member"}} = my_chat_member}) do
    Bot.join(%{
      chat_id: my_chat_member["chat"]["id"],
      username: my_chat_member["from"]["username"],
      name: my_chat_member["from"]["first_name"] <> " " <> my_chat_member["from"]["last_name"]
    })
  end

  def action(_) do
    IO.inspect("Uncommon request")
  end
end
