defmodule Dash.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dash.Blog.Post

  schema "posts" do
    field :title, :string
    field :summary, :string
    field :body, :string
    field :permalink, :string
    field :tags, {:array, :string}
    field :published, :boolean, default: false
    field :published_at, :utc_datetime
    field :tags_text, :string, virtual: true

    belongs_to :user, Dash.Blog.User

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body, :permalink, :tags_text, :tags, :summary, :published, :published_at, :user_id])
    |> validate_required([:title])
    |> unique_constraint(:permalink)
    |> inflate_tags
    |> update_published
  end

  def update_published(changeset) do
    case {changeset.changes[:published], changeset.data.published} do
      {true, false} -> put_published_at(changeset)
      _ -> changeset
    end
  end

  def put_published_at(changeset) do
    change(changeset,
      %{published_at: Ecto.DateTime.utc(), published: true})
  end

  def inflate_tags(changeset) do
    case changeset.changes[:tags_text] do
      nil -> changeset
      _ ->
        new_tags = String.split(changeset.params["tags_text"], ",", trim: true)
                    |> Enum.map(&String.trim/1)

        put_change(changeset, :tags, new_tags)
    end
  end

  @doc """
  Flatten a `tags` field into a string separated by comma and sets new
  value on `tags_text` virtual field. `tags` field is
  a Postgresql array.

  If `tags` field is empty, this method sets an empty string.
  """
  def flat_tags(%Post{} = post) do
    flatten = case post.tags do
      [_|_] -> Enum.join(post.tags, ", ")
      _ -> ""
    end

    Map.put(post, :tags_text, flatten)
    post
  end
end
