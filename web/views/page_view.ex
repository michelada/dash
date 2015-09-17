defmodule Dash.PageView do
  use Dash.Web, :view

  alias Earmark.Options

  def markdown_to_html(content) do
    Earmark.to_html(content, %Options{gfm: false}) |> raw
  end

  def human_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Chronos.Formatter.strftime(date, "%B %d, %Y")
  end

  def author_name(user) when user == nil do
    "Michelada.io"
  end

  def author_name(user) do
    user.name
  end
end
