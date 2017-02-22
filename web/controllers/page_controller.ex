defmodule Dash.PageController do
  use Dash.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
