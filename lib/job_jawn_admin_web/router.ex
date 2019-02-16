defmodule JJWeb.Router do
  use JJWeb, :router

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

  scope "/", JJWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/signup", JJWeb.Signup, as: :signup do
    pipe_through :browser

    resources "/users", UserController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", JJWeb do
  #   pipe_through :api
  # end
end
