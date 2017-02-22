defmodule Dash.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :permalink, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
