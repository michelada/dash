defmodule DashWeb.SitemapController do
  use DashWeb, :controller

  alias Dash.Blog

  def index(conn, _params) do
    posts = Blog.list_published_posts()

    conn
    |> put_layout(false)
    |> put_resp_content_type("text/xml")
    |> render("index.html", posts: posts)
  end
end
