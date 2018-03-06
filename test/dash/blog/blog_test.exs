defmodule Dash.BlogTest do
  use Dash.DataCase

  alias Dash.Blog

  describe "posts" do
    alias Dash.Blog.Post

    @valid_attrs %{body: "some content", permalink: "some content", tags_text: "some, content", title: "some content"}
    @update_attrs %{published: true}
    @invalid_attrs %{title: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(%{name: "Sample user", bio: "Sample bio", nickname: "Nick"})
        |> Blog.create_user()

      user
    end

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{user_id: user_fixture().id})
        |> Blog.create_post()

      Dash.Repo.get!(Post, post.id) |> Dash.Repo.preload(:user)
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.title == "some content"
      assert post.tags == ["some", "content"]
      post = Post.flat_tags(post)
      assert post.tags_text == "some, content"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Blog.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.published == true
      assert post.published_at != nil
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end

    test "list_published_posts/0 returns all published posts" do
      post_fixture()
      post_published = post_fixture(%{published: true, permalink: "published"})
      assert Blog.list_published_posts() == [post_published]
    end
  end
end
