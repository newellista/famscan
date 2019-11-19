defmodule UiWeb.Router do
  use UiWeb, :router

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

  scope "/", UiWeb do
    pipe_through :browser

    resources "/repositories", RepositoryController do
      resources "/contacts", ContactController, only: [:create]
      resources "/volumes", VolumeController, only: [:create]
    end

    resources "/volumes", VolumeController, only: [:index, :show] do
      resources "/images", ImageController, only: [:create, :show, :index]
    end
  end
end
