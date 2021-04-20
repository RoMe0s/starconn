defmodule Starconn.TelegramBotTest do
  use Starconn.DataCase

  alias Starconn.TelegramBot

  describe "chats" do
    alias Starconn.TelegramBot.Chat

    @valid_attrs %{chat_id: "some chat_id", first_name: "some first_name", last_name: "some last_name", username: "some username"}
    @update_attrs %{chat_id: "some updated chat_id", first_name: "some updated first_name", last_name: "some updated last_name", username: "some updated username"}
    @invalid_attrs %{chat_id: nil, first_name: nil, last_name: nil, username: nil}

    def chat_fixture(attrs \\ %{}) do
      {:ok, chat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TelegramBot.create_chat()

      chat
    end

    test "list_chats/0 returns all chats" do
      chat = chat_fixture()
      assert TelegramBot.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert TelegramBot.get_chat!(chat.id) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      assert {:ok, %Chat{} = chat} = TelegramBot.create_chat(@valid_attrs)
      assert chat.chat_id == "some chat_id"
      assert chat.first_name == "some first_name"
      assert chat.last_name == "some last_name"
      assert chat.username == "some username"
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TelegramBot.create_chat(@invalid_attrs)
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{} = chat} = TelegramBot.update_chat(chat, @update_attrs)
      assert chat.chat_id == "some updated chat_id"
      assert chat.first_name == "some updated first_name"
      assert chat.last_name == "some updated last_name"
      assert chat.username == "some updated username"
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = TelegramBot.update_chat(chat, @invalid_attrs)
      assert chat == TelegramBot.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = TelegramBot.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> TelegramBot.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = TelegramBot.change_chat(chat)
    end
  end
end
