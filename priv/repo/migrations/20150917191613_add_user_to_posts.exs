defmodule Dash.Repo.Migrations.AddUserToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, :integer
    end

    create index(:posts, [:user_id])
  end
end
