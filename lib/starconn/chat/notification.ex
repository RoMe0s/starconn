defmodule Starconn.Chat.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :key, :string
    field :payload, :string
    field :sent_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:key, :payload, :sent_at])
    |> validate_required([:key, :payload, :sent_at])
  end
end
