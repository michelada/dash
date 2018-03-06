defmodule DashWeb.SitemapControllerTest do
  use DashWeb.ConnCase

  describe "index" do
    test "list all published posts", %{conn: conn} do
      fixture(:post, %{title: "My First", permalink: "my-first"})
      fixture(:post, %{title: "My Second", permalink: "my-second", published: true})
      fixture(:post, %{title: "My Third", permalink: "my-third", published: true})

      conn = get conn, sitemap_path(conn, :index)
      assert response_content_type(conn, :xml) =~ "charset=utf-8"
      assert response(conn, 200) =~ "my-second"
      assert response(conn, 200) =~ "my-third"
      refute response(conn, 200) =~ "my-first"
    end
  end
end
