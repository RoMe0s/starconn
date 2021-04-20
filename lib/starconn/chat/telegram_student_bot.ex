defmodule Starconn.Chat.TelegramStudentBot do

  alias Starconn.Accounts.UserService
  alias Starconn.Chat.ChatUser.ChatUser
  alias Starconn.Chat.ChatUser.ChatUserService
  alias Starconn.Chat.ChatAction.ChatActionService

  @i_will_correct_my_name_option "I\'ll correct my name."

  def join(%{chat_id: _, username: _, name: _} = user_info) do
    chat_user = ChatUserService.insert!(user_info)

    greeting(chat_user)
    require_name(chat_user)
  end

  def receive(%{chat_id: chat_id, message: message}) do
    chat_user = ChatUserService.find_by_chat_id(chat_id)
    chat_action = ChatActionService.find_last(chat_user.id)

    handle_action(chat_action.key, chat_user, message)
  end

  def leave(username) do
    ChatUserService.delete_by_username(username)
  end

  defp greeting(%ChatUser{} = chat_user) do
    Nadia.send_message(chat_user.chat_id, "Welcome to a study bot.")
  end

  defp require_name(%ChatUser{} = chat_user) do
    ChatActionService.new(:expect_name_option, chat_user.id)

    Nadia.send_message(
      chat_user.chat_id,
      "Please, specify a correct name for your teacher",
      reply_markup: %{
        resize_keyboard: true,
        one_time_keyboard: true,
        keyboard: [
          [
            %{
              text: @i_will_correct_my_name_option,
            },
            %{
              text: "Name \"" <> chat_user.name <> "\" is correct.",
            }
          ]
        ]
      }
    )
  end

  defp handle_action(:expect_name_option, %ChatUser{} = chat_user, @i_will_correct_my_name_option) do
    ChatActionService.new(:expect_name, chat_user.id)
  end

  defp handle_action(:expect_name_option, %ChatUser{} = chat_user, _message) do
    name_is_chosen(chat_user, chat_user.name)
  end

  defp handle_action(:expect_name, %ChatUser{} = chat_user, message) do
    use_my_exising_name_message = "Name \"" <> chat_user.name <> "\" is correct."

    case message do
      @i_will_correct_my_name_option ->
        Nadia.send_message(chat_user.chat_id, "Please specify a valid name.")
      ^use_my_exising_name_message ->
        name_is_chosen(chat_user, chat_user.name)
      _ ->
        name_is_chosen(chat_user, message)
    end
  end

  defp handle_action(_, %ChatUser{} = chat_user, message) do
    Nadia.send_message(chat_user.chat_id, "Action \"" <> message <> "\" is unknown")
  end

  # own callbacks
  defp name_is_chosen(%ChatUser{} = chat_user, name) do
    ChatActionService.new(:expect_teacher, chat_user.id)
    user =
      case chat_user.user_id do
        user_id when is_integer(user_id) ->
          UserService.update(%{user_id: user_id, name: name})
        _ ->
          UserService.insert(%{name: name})
      end
    ChatUserService.update(%{id: chat_user.id, user_id: user.id, name: name})

    Nadia.send_message(
      chat_user.chat_id,
      "Your new name is: " <> name,
      reply_markup: %{
        hide_keyboard: true
      }
    )
  end
end
