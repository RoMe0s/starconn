defmodule Starconn.School.Teacher.Teacher do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teachers" do
    field :organization_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:user_id, :organization_id])
    |> validate_required([:user_id, :organization_id])
  end
end
