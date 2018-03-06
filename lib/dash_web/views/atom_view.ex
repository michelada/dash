defmodule DashWeb.AtomView do
  use DashWeb, :view

  use Timex

  def utc_date(date) do
    Timex.format!(date, "%Y-%m-%dT%H:%M:%SZ", :strftime)
  end

  def author_name(user) when user == nil do
    "michelada.io"
  end

  def author_name(user) do
    user.name
  end
end
