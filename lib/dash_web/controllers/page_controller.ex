defmodule DashWeb.PageController do
  use DashWeb, :controller

  alias Dash.Blog

  def index(conn, _params) do
    [first|posts] = Blog.list_published_posts()
    render(conn, "index.html", first: first, posts: posts)
  end

  def show(conn, %{"permalink" => permalink}) do
    post = Blog.get_post_by_permalink!(permalink)
    render(conn, "show.html", post: post)
  end
end
