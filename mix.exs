defmodule Dash.Mixfile do
  use Mix.Project

  def project do
    [app: :dash,
     version: "0.0.6",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Dash, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :linguist, :gettext,
                    :phoenix_ecto, :postgrex, :earmark, :chronos]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.1"},
     {:phoenix_ecto, "~> 2.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.3"},
     {:earmark, "~>0.1.17"},
     {:chronos, "~> 1.5.1"},
     {:linguist, "~>0.1.5"},
     {:gettext, "~> 0.9"},
     {:exrm, "~>1.0.0"}, 
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"}]
  end
end
