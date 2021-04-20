defmodule Starconn.School.Class.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :key, :string
    field :name, :string
    field :organization_id, :integer
    field :teacher_id, :integer
    field :timetable_id, :integer

    timestamps()
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:organization_id, :teacher_id, :timetable_id, :key, :name])
    |> validate_required([:organization_id, :teacher_id, :timetable_id, :key, :name])
  end
end
