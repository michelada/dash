defmodule Dash.AtomView do
  use Dash.Web, :view

  def utc_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Chronos.Formatter.strftime(date, "%Y-%m-%dT%H:%M:%SZ")
  end

  def author_name(user) when user == nil do
    "Michelada.io"
  end

  def author_name(user) do
    user.name
  end
end
