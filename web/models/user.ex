defmodule Dash.User do
  use Dash.Web, :model

  schema "users" do
    field :name, :string
    field :bio, :string
    field :nickname, :string
    field :social, :map

    has_many :posts, Dash.Post

    timestamps
  end

  @required_fields ~w(name nickname)
  @optional_fields ~w(bio social)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
