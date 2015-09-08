defmodule Dash.Repo.Migrations.AddPermalinkUniqueIndexToPosts do
  use Ecto.Migration

  def change do
    create index(:posts, [:permalink], unique: true)
  end
end
