defmodule StrongbondWeb.CharacterHTML do
  use StrongbondWeb, :html

  embed_templates "character_html/*"

  @doc """
  Renders a character form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def character_form(assigns)
end
