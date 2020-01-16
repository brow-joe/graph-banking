defmodule GraphBanking.PageController do
  use GraphBanking.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
