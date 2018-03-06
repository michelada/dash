defmodule DashWeb.PostControllerTest do
  use DashWeb.ConnCase

  @create_attrs %{body: "some content", permalink: "some content", tags: ["some","content"] , title: "some content"}
  @update_attrs %{body: "new body", tags_text: "new, post"}
  @invalid_attrs %{title: ""}

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get conn, post_path(conn, :index)
      assert html_response(conn, 200) =~ "Posts"
    end
  end

  describe "new" do
    test "renders form for new resources", %{conn: conn} do
      conn = get conn, post_path(conn, :new)
      assert html_response(conn, 200) =~ "New post"
    end
  end

  describe "create" do
    test "creates resource and redirects when data is valid", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @create_attrs
      assert redirected_to(conn) == post_path(conn, :index)
      assert Repo.get_by!(Post, @create_attrs)
    end

    test "does not create resource and renders errors when data is invalid", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @invalid_attrs
      assert html_response(conn, 200) =~ "New post"
      assert html_response(conn, 200) =~ ~r/Title can.*t be blank/
    end
  end

  describe "show" do
    test "shows chosen resource", %{conn: conn} do
      post = fixture(:post)
      conn = get conn, post_path(conn, :show, post)
      assert html_response(conn, 200) =~ post.title
    end

    test "renders page not found when id is nonexistent", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        get conn, post_path(conn, :show, -1)
      end
    end
  end

  describe "edit" do
    test "renders form for editing chosen resource", %{conn: conn} do
      post = fixture(:post)
      conn = get conn, post_path(conn, :edit, post)
      assert html_response(conn, 200) =~ "Edit post"
    end

    test "renders page not found when id is nonexistent", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        get conn, post_path(conn, :edit, -1)
      end
    end
  end

  describe "update" do
    test "updates chosen resource and redirects when data is valid", %{conn: conn} do
      post = fixture(:post)
      conn = put conn, post_path(conn, :update, post), post: @update_attrs
      assert redirected_to(conn) == post_path(conn, :show, post)

      %{body: body} = @update_attrs
      assert Repo.get_by!(Post, %{body: body})
    end

    test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
      post = fixture(:post)
      conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit post"
    end
  end

  describe "delete" do
    test "deletes chosen resource", %{conn: conn} do
      post = fixture(:post)
      conn = delete conn, post_path(conn, :delete, post)
      assert redirected_to(conn) == post_path(conn, :index)
      assert_raise Ecto.NoResultsError, fn ->
        Repo.get!(Post, post.id)
      end
    end
  end
end
