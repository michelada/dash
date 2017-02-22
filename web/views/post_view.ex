defmodule Dash.PostView do
  use Dash.Web, :view

  import Dash.PostHelper

  def published(%{published: true}) do
    "- (published)"
  end

  def published(%{published: false}) do
    ""
  end

  def render("styles.html", assigns) do
    conn = assigns[:conn]
    raw "<link rel='stylesheet' href='#{static_path(conn, "/css/admin.css")}'>"
  end
end
