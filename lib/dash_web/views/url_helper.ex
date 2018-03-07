defmodule DashWeb.UrlHelper do
  alias Plug.Conn
  import DashWeb.Router.Helpers

  def static_url_with_params(%Conn{} = conn, path, params) do
    [url|_] = static_url(conn, path)
              |> String.split("?")
    [url, params]
    |> Enum.join
  end
end
