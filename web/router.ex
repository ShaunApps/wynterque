defmodule Wynterque.Router do
  use Wynterque.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Wynterque.Auth, repo: Wynterque.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Wynterque do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create, :edit, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Wynterque do
  #   pipe_through :api
  # end
end
