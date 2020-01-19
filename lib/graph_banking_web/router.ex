defmodule GraphBankingWeb.Router do
  use GraphBankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: GraphBankingWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GraphBankingWeb.Schema.Schema,
      interface: :simple
  end
end
