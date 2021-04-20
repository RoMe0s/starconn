defmodule Starconn.School.Timetable.TimetableHour do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timetable_hours" do
    field :day_id, :integer
    field :from, :time
    field :to, :time

    timestamps()
  end

  @doc false
  def changeset(timetable_hour, attrs) do
    timetable_hour
    |> cast(attrs, [:day_id, :from, :to])
    |> validate_required([:day_id, :from, :to])
  end
end
