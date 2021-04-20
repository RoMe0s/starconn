defmodule Starconn.School.Student.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :class_id, :integer
    field :price, :float
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:user_id, :class_id, :price])
    |> validate_required([:user_id, :class_id, :price])
  end
end
