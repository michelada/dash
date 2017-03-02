# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dash,
  ecto_repos: [Dash.Repo]

# Configures the endpoint
config :dash, Dash.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vdg039YkEHe0Hsj6pwY2rlTGYDUh2d5TcLftkgVzfJBL3GKLD5FfXQ2vJD8EuweX",
  render_errors: [view: Dash.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dash.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
