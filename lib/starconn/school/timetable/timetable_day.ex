defmodule Starconn.School.Timetable.TimetableDay do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timetable_days" do
    field :number, :integer
    field :timetable_id, :integer

    timestamps()
  end

  @doc false
  def changeset(timetable_day, attrs) do
    timetable_day
    |> cast(attrs, [:timetable_id, :number])
    |> validate_required([:timetable_id, :number])
  end
end
