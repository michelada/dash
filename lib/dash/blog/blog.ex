defmodule Dash.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Dash.Repo

  alias Dash.Blog.Post
  alias Dash.Blog.User

  def list_posts do
    Repo.all(from p in Post, preload: [:user], order_by: [desc: p.updated_at])
  end

  def list_published_posts do
    Repo.all(
      from p in Post, where: p.published == true,
        preload: [:user],
        order_by: [desc: p.published_at]
    )
  end

  def get_post!(id) do
    Repo.get!(Post, id) |> Repo.preload(:user)
  end

  def get_post_by_permalink!(permalink) do
    Repo.get_by!(Post, permalink: permalink) |> Repo.preload(:user)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
