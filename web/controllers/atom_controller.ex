defmodule Dash.AtomController do
  use Dash.Web, :controller

  import Ecto.Query, only: [from: 2]

  alias Dash.Post

  def index(conn, _params) do
    query = from p in Post, where: p.published == true,
      preload: [:user],
      order_by: [desc: p.published_at]

    posts = Repo.all(query)

    conn
    |> put_layout(false)
    |> put_resp_content_type("text/xml")
    |> render("index.html", posts: posts)
  end
end
