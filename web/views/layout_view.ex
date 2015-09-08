defmodule Dash.LayoutView do
  use Dash.Web, :view

  def page_title(_conn, assigns) do
    case assigns[:post] do
      nil -> I18n.t!("en", "seo.title")
      _ -> assigns[:post].title
    end
  end

  def page_description(_conn, assigns) do
    case assigns[:post] do
      nil -> I18n.t!("en", "seo.description")
      _ -> assigns[:post].summary
    end
  end

  def current_page_url(conn, assigns) do
    path = case assigns[:post] do
      nil -> static_url(conn, "/")
      _ -> "/" <> assigns[:post].permalink
    end

    static_url(conn, path)
  end
end
