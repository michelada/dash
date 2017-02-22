defmodule Dash.Repo.Migrations.AddPublishedAtAndSummaryToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :published_at, :utc_datetime
      add :summary, :text
    end
  end
end
