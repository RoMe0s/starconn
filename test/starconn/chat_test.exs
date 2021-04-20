defmodule Starconn.ChatTest do
  use Starconn.DataCase

  alias Starconn.Chat

  describe "chat_users" do
    alias Starconn.Chat.ChatUser

    @valid_attrs %{chat_id: 42, first_name: "some first_name", last_name: "some last_name", user_id: 42, username: "some username"}
    @update_attrs %{chat_id: 43, first_name: "some updated first_name", last_name: "some updated last_name", user_id: 43, username: "some updated username"}
    @invalid_attrs %{chat_id: nil, first_name: nil, last_name: nil, user_id: nil, username: nil}

    def chat_user_fixture(attrs \\ %{}) do
      {:ok, chat_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_chat_user()

      chat_user
    end

    test "list_chat_users/0 returns all chat_users" do
      chat_user = chat_user_fixture()
      assert Chat.list_chat_users() == [chat_user]
    end

    test "get_chat_user!/1 returns the chat_user with given id" do
      chat_user = chat_user_fixture()
      assert Chat.get_chat_user!(chat_user.id) == chat_user
    end

    test "create_chat_user/1 with valid data creates a chat_user" do
      assert {:ok, %ChatUser{} = chat_user} = Chat.create_chat_user(@valid_attrs)
      assert chat_user.chat_id == 42
      assert chat_user.first_name == "some first_name"
      assert chat_user.last_name == "some last_name"
      assert chat_user.user_id == 42
      assert chat_user.username == "some username"
    end

    test "create_chat_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_chat_user(@invalid_attrs)
    end

    test "update_chat_user/2 with valid data updates the chat_user" do
      chat_user = chat_user_fixture()
      assert {:ok, %ChatUser{} = chat_user} = Chat.update_chat_user(chat_user, @update_attrs)
      assert chat_user.chat_id == 43
      assert chat_user.first_name == "some updated first_name"
      assert chat_user.last_name == "some updated last_name"
      assert chat_user.user_id == 43
      assert chat_user.username == "some updated username"
    end

    test "update_chat_user/2 with invalid data returns error changeset" do
      chat_user = chat_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_chat_user(chat_user, @invalid_attrs)
      assert chat_user == Chat.get_chat_user!(chat_user.id)
    end

    test "delete_chat_user/1 deletes the chat_user" do
      chat_user = chat_user_fixture()
      assert {:ok, %ChatUser{}} = Chat.delete_chat_user(chat_user)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_chat_user!(chat_user.id) end
    end

    test "change_chat_user/1 returns a chat_user changeset" do
      chat_user = chat_user_fixture()
      assert %Ecto.Changeset{} = Chat.change_chat_user(chat_user)
    end
  end

  describe "notifications" do
    alias Starconn.Chat.Notification

    @valid_attrs %{key: "some key", payload: "some payload", sent_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{key: "some updated key", payload: "some updated payload", sent_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{key: nil, payload: nil, sent_at: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Chat.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Chat.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Chat.create_notification(@valid_attrs)
      assert notification.key == "some key"
      assert notification.payload == "some payload"
      assert notification.sent_at == ~N[2010-04-17 14:00:00]
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{} = notification} = Chat.update_notification(notification, @update_attrs)
      assert notification.key == "some updated key"
      assert notification.payload == "some updated payload"
      assert notification.sent_at == ~N[2011-05-18 15:01:01]
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_notification(notification, @invalid_attrs)
      assert notification == Chat.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Chat.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Chat.change_notification(notification)
    end
  end
end
