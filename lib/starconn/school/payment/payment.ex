defmodule Starconn.School.Payment.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :float
    field :lesson_id, :integer
    field :note, :string

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:lesson_id, :amount, :note])
    |> validate_required([:lesson_id, :amount, :note])
  end
end
