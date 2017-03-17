defmodule Dash.PostHelper do
  import Phoenix.HTML, only: [raw: 1]

  alias Earmark.Options

  def markdown_to_html(content) do
    Earmark.as_html(content, %Options{gfm: false}) |> raw
  end

  def human_date(date) when is_nil(date), do: ""

  def human_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Chronos.Formatter.strftime(date, "%B %d, %Y")
  end

  def author_name(user) when user == nil do
    "michelada.io"
  end

  def author_name(user) do
    user.name
  end
end
