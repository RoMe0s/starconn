defmodule Starconn.School.Timetable.Timetable do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timetables" do
    field :default, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(timetable, attrs) do
    timetable
    |> cast(attrs, [:name, :default])
    |> validate_required([:name, :default])
  end
end
