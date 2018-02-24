defmodule DevexWeb.PageController do
  use DevexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
