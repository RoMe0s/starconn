defmodule Starconn.Content.Post.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :slug, :string
    field :title, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:slug, :title, :content])
    |> validate_required([:slug, :title, :content])
    |> unique_constraint(:slug)
  end
end
