defmodule Dash.Blog.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dash.Blog.User

  schema "users" do
    field :name, :string
    field :bio, :string
    field :nickname, :string
    field :social, :map

    has_many :posts, Dash.Blog.Post

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :nickname, :bio, :social])
    |> validate_required([:name, :nickname])
  end
end
