defmodule Mix.Tasks.Telegram.Init do
  use Mix.Task

  @shortdoc "Sends a greeting to us from Hello Phoenix"

  @moduledoc """
  This is where we would put any long form documentation or doctests.
  """

  def run([url]) when is_binary(url) do
    HTTPoison.start()

    HTTPoison.get!(
      "https://api.telegram.org/bot1764304085:AAFztXs6IHdylYSe2RU9-zXwjbOJfT3Be-E/setWebhook?url=" <> String.trim_trailing(url, "/") <> "/webhook/1764304085:AAFztXs6IHdylYSe2RU9-zXwjbOJfT3Be-E/student"
    )

    Mix.shell().info("Webhooks configuration changed.")
  end
end
