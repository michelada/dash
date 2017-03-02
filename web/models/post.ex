defmodule Dash.Post do
  use Dash.Web, :model

  schema "posts" do
    field :title, :string
    field :summary, :string
    field :body, :string
    field :permalink, :string
    field :tags, {:array, :string}
    field :published, :boolean, default: false
    field :published_at, Ecto.DateTime
    field :tags_text, :string, virtual: true

    belongs_to :user, Dash.User

    timestamps()
  end

  @required_fields ~w(title)
  @optional_fields ~w(body permalink tags summary published published_at user_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :body, :permalink, :tags, :summary, :published, :published_at, :user_id])
    |> validate_required([:title])
    |> inflate_tags
    |> update_published
  end

  def update_published(changeset) do
    case {changeset.changes[:published], changeset.params["published"]} do
      {false, true} -> put_published_at(changeset)
      _ -> changeset
    end
  end

  def put_published_at(changeset) do
    change(changeset,
      %{published_at: Ecto.DateTime.local, published: true})
  end

  def inflate_tags(changeset) do
    case changeset.params["tags_text"] do
      nil -> changeset
      _ ->
        new_tags = String.split(changeset.params["tags_text"], ",", trim: true)
                    |> Enum.map(&String.strip/1)

        put_change(changeset, :tags, new_tags)
    end
  end

  @doc """
  Flatten a `tags` field into a string separated by comma and sets new
  value on `tags_text` virtual field. `tags` field is
  a Postgresql array.

  If `tags` field is empty, this method sets an empty string.
  """
  def flat_tags(post) do
    flatten = case post.tags do
      [_|_] -> Enum.join(post.tags, ", ")
      _ -> ""
    end

    Map.put(post, :tags_text, flatten)
  end
end
