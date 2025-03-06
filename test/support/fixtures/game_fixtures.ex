defmodule Strongbond.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Strongbond.Game` context.
  """

  @doc """
  Generate a character.
  """
  def character_fixture(attrs \\ %{}) do
    {:ok, character} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Strongbond.Game.create_character()

    character
  end
end
