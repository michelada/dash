defmodule Dash.Post do
  use Dash.Web, :model

  schema "posts" do
    field :title, :string
    field :summary, :string
    field :body, :string
    field :permalink, :string
    field :tags, {:array, :string}
    field :published_at, Ecto.Date
    field :tags_text, :string, virtual: true

    timestamps
  end

  @required_fields ~w(title)
  @optional_fields ~w(body permalink tags summary published_at)

  after_load :flat_tags

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> inflate_tags
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
