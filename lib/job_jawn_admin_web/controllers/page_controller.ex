defmodule JJWeb.PageController do
  use JJWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
