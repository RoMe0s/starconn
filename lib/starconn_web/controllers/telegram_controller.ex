defmodule StarconnWeb.TelegramController do
  use StarconnWeb, :controller

  alias Starconn.Chat.TelegramStudentBotController

  def teacher(conn, _params) do
    render(conn, "success.json")
  end

  def student(conn, params) do
    TelegramStudentBotController.action(params)

    render(conn, "success.json")
  end
end

# https://api.telegram.org/bot1764304085:AAFztXs6IHdylYSe2RU9-zXwjbOJfT3Be-E/setWebhook?url=https://49806f668dfe.ngrok.io/webhook/1764304085:AAFztXs6IHdylYSe2RU9-zXwjbOJfT3Be-E
