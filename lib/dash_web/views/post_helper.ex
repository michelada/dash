defmodule DashWeb.PostHelper do
  import Phoenix.HTML, only: [raw: 1]

  use Timex
  alias Earmark.Options

  def markdown_to_html(content) do
    Earmark.to_html(content, %Options{gfm: false}) |> raw
  end

  def human_date(date) when is_nil(date), do: ""

  def human_date(date) do
    Timex.format!(date, "%B %d, %Y", :strftime)
  end

  def author_name(user) when user == nil do
    "michelada.io"
  end

  def author_name(user) do
    user.name
  end
end
