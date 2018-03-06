defmodule DashWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import DashWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint DashWeb.Endpoint

      alias Dash.Blog
      alias Dash.Repo
      alias Dash.Blog.Post

      @user_attrs %{name: "Sample user", bio: "My bio", nickname: "user", social: %{"twitter" => "https://twitter.com/dash"}}
      @post_attrs %{body: "My content", permalink: "my-post", title: "My post", tags: ["post", "first"]}

      def fixture(changeset, attrs \\ %{})
      def fixture(:user, attrs) do
        {:ok, user} =
          attrs
          |> Enum.into(@user_attrs)
          |> Blog.create_user()

        user
      end

      def fixture(:post, attrs) do
        {:ok, post} =
          attrs
          |> Enum.into(@post_attrs)
          |> Enum.into(%{user_id: fixture(:user).id})
          |> Blog.create_post()

        Repo.get!(Post, post.id) |> Repo.preload(:user)
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Dash.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Dash.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
