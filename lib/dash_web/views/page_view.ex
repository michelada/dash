defmodule DashWeb.PageView do
  use DashWeb, :view

  import DashWeb.UrlHelper
  import DashWeb.PostHelper

  def render_author(_conn, author) when author == nil do
    ""
  end

  def render_author(conn, author) do
    render_existing(DashWeb.PageView, "author.html",
      %{conn: conn, author: author})
  end
end
