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

  pipeline :guardian do
    plug JJWeb.Guardian.Plug
    plug JJWeb.Guardian.CurrentUserPlug
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", JJWeb do
    pipe_through [:browser, :guardian]

    get "/", PageController, :index
  end

  scope "/signup", JJWeb.Signup, as: :signup do
    pipe_through [:browser, :guardian]

    resources "/users", UserController, only: [:new, :create]
  end

  scope "/login", JJWeb.Auth, as: :auth do
    pipe_through [:browser, :guardian]

    resources "/users", UserController, only: [:new, :create]
  end

  scope "/", JJWeb do
    pipe_through [:browser, :guardian, :ensure_auth]
    post("/logout", Auth.UserController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", JJWeb do
  #   pipe_through :api
  # end
end
