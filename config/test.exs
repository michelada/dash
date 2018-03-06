use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dash, DashWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :dash, Dash.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dash_test",
  pool: Ecto.Adapters.SQL.Sandbox

config :dash,
  admin_path: System.get_env("ADMIN_PATH") || 'admin'
