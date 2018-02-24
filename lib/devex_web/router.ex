defmodule DevexWeb.Router do
  use DevexWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", DevexWeb.Api do
    pipe_through(:api)

    scope "/rest", Rest, as: :rest do
      scope "/table", Table, as: :table do
        resources("/v1/:table_name", V1Controller, except: [:new, :edit])
      end
    end
  end

  scope "/", DevexWeb do
    # pipelines allow a set of middleware transformations to be applied to different sets of routes
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    # get("/hello", HelloController, :index)
    # get("/hello/:messenger", HelloController, :show)

    # resources("/users", UserController, only: [:index, :show])
  end
end
