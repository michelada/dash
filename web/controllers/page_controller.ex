defmodule Dash.PageController do
  use Dash.Web, :controller

  import Ecto.Query, only: [from: 2]

  alias Dash.Post

  def index(conn, _params) do
    query = from p in Post, where: p.published == true,
      preload: [:user],
      order_by: [desc: p.published_at]

    [first|posts] = Repo.all(query)
    render(conn, "index.html", first: first, posts: posts)
  end

  def show(conn, %{"permalink" => permalink}) do
    post = Repo.get_by!(Post, permalink: permalink) |> Repo.preload(:user)
    render(conn, "show.html", post: post)
  end
end
