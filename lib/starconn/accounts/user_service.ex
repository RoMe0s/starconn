defmodule Starconn.Accounts.UserService do

  alias Starconn.Repo
  alias Starconn.Accounts.User

  def insert(user_info) do
    %User{}
    |> User.changeset(user_info)
    |> Repo.insert!()
  end

  def update(user_info) do
    %User{}
    |> User.changeset(user_info)
    |> Repo.update!()
  end

  def create(%{name: _} = user_info) do
    %User{}
    |> User.changeset(user_info)
    |> Repo.update!()
  end
end
