defmodule DashWeb.Router do
  use DashWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :xml do
    plug :accepts, ["xml"]
  end

  scope "/", DashWeb do
    pipe_through :xml

    get "/atom.xml", AtomController, :index
    get "/sitemap.xml", SitemapController, :index
  end

  scope "/#{Application.get_env(:dash, :admin_path)}", DashWeb do
    pipe_through :browser # Use the default browser stack

    resources "/", PostController
  end

  scope "/", DashWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/:permalink", PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dash do
  #   pipe_through :api
  # end
end
