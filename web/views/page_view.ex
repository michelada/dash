defmodule Dash.PageView do
  use Dash.Web, :view

  import Dash.PostHelper

  def render_author(_conn, author) when author == nil do
    ""
  end

  def render_author(conn, author) do
    render_existing(Dash.PageView, "author.html",
      %{conn: conn, author: author})
  end
end
