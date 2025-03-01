defmodule NayshWeb.NayshController do
  use NayshWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def home(conn, _params) do
    conn
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render(:home, layout: false)
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
end
