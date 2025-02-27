defmodule NayshWeb.NayshController do
  use NayshWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
