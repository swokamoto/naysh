defmodule Strongbond.Game.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field :name, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
