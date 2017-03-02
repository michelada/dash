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

  def flat_tags(post) do
    flatten = case post.tags do
      [_|_] -> Enum.join(post.tags, ", ")
      _ -> ""
    end
    flatten
  end

  def tags(post) do
    tags = case post.tags do
      nil -> []
      _ -> post.tags
    end

    tags
  end
end
