defmodule NayshWeb.Router do
  use NayshWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NayshWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NayshWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NayshWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/naysh", NayshController, :index
    get "/naysh/:messenger", NayshController, :show
    get "/redirect_test", PageController, :redirect_test
    #resources "/users", UserController do
      #resources "/posts", PostController

    resources "/reviews", ReviewController

  end

  scope "/admin", NayshWeb do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  # Other scopes may use custom stacks.
  scope "/api", NayshWeb do
    pipe_through :api

    resources "/reviews", ReviewController
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:naysh, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: NayshWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
