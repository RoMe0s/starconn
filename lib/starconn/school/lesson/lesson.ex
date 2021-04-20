defmodule Starconn.School.Lesson.Lesson do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lessons" do
    field :class_id, :integer
    field :date, :date
    field :from, :time
    field :payload, :string
    field :student_id, :integer
    field :teacher_id, :integer
    field :to, :time

    timestamps()
  end

  @doc false
  def changeset(lesson, attrs) do
    lesson
    |> cast(attrs, [:teacher_id, :student_id, :class_id, :date, :from, :to, :payload])
    |> validate_required([:teacher_id, :student_id, :class_id, :date, :from, :to, :payload])
  end
end
