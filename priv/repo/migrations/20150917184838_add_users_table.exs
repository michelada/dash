defmodule Dash.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS hstore"

    create table(:users) do
      add :name, :string
      add :bio, :text
      add :nickname, :string
      add :social, :hstore

      timestamps()
    end
  end
end
