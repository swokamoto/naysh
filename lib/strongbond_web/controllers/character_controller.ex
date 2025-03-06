defmodule StrongbondWeb.CharacterController do
  use StrongbondWeb, :controller

  alias Strongbond.Game
  alias Strongbond.Game.Character

  def index(conn, _params) do
    characters = Game.list_characters()
    render(conn, :index, characters: characters)
  end

  def new(conn, _params) do
    changeset = Game.change_character(%Character{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"character" => character_params}) do
    case Game.create_character(character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character created successfully.")
        |> redirect(to: ~p"/characters")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Game.get_character!(id)
    render(conn, :show, character: character)
  end

  def edit(conn, %{"id" => id}) do
    character = Game.get_character!(id)
    changeset = Game.change_character(character)
    render(conn, :edit, character: character, changeset: changeset)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Game.get_character!(id)

    case Game.update_character(character, character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character updated successfully.")
        |> redirect(to: ~p"/characters/#{character}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, character: character, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Game.get_character!(id)
    {:ok, _character} = Game.delete_character(character)

    conn
    |> put_flash(:info, "Character deleted successfully.")
    |> redirect(to: ~p"/characters")
  end
end
