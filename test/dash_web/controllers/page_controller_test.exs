defmodule DashWeb.PageControllerTest do
  use DashWeb.ConnCase

  describe "index" do
    test "list posts", %{conn: conn} do
      fixture(:post, %{title: "First post", permalink: "my-first_post", published: true})
      fixture(:post, %{title: "Second post", permalink: "my-second-post", published: true})

      conn = get conn, page_path(conn, :index)
      assert html_response(conn, 200) =~ "First post"
      assert html_response(conn, 200) =~ "Second post"
    end
  end

  describe "show" do
    test "find post by permalink", %{conn: conn} do
      post = fixture(:post)
      conn = get conn, page_path(conn, :show, post.permalink)
      assert html_response(conn, 200) =~ "My post"
    end

    test "post not found", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        get conn, page_path(conn, :show, "something")
      end
    end
  end
end
