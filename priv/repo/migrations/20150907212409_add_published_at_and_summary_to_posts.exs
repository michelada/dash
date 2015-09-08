defmodule Dash.Repo.Migrations.AddPublishedAtAndSummaryToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :published_at, :datetime
      add :summary, :text
    end
  end
end
