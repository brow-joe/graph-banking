defmodule GraphBanking.Router do
  use GraphBanking.Web, :router

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

  scope "/", GraphBanking do
    pipe_through :browser # Use the default browser stack

    resources "/web", AccountController do
      post "/transaction", AccountController, :add_transaction
    end

    # forward "/graph", Absinthe.Plug, schema: GraphBanking.Schema
    # forward "/graphiql", Absinthe.Plug.GraphiQL, schema: GraphBanking.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", GraphBanking do
  #   forward "/graph", Absinthe.Plug, schema: GraphBanking.Schema
  #   forward "/graphiql", Absinthe.Plug.GraphiQL, schema: GraphBanking.Schema
  # end
end
