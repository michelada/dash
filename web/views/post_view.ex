defmodule Dash.PostView do
  use Dash.Web, :view

  def render("styles.html", assigns) do
    conn = assigns[:conn]
    raw "<link rel='stylesheet' href='#{static_path(conn, "/css/admin.css")}'>"
  end
end
