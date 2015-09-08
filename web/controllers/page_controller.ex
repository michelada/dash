defmodule Dash.PageController do
  use Dash.Web, :controller

  alias Dash.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"permalink" => permalink}) do
    post = Repo.get_by!(Post, permalink: permalink)
    render(conn, "show.html", post: post)
  end
end
