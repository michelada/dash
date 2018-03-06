defmodule DashWeb.PostView do
  use DashWeb, :view

  import DashWeb.PostHelper

  def published(%{published: true}) do
    "- (published)"
  end

  def published(%{published: false}) do
    ""
  end

  def render("styles.html", assigns) do
    conn = assigns[:conn]
    raw "<link rel='stylesheet' href='#{static_url(conn, "/css/admin.css")}'>"
  end
end
