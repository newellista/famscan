use Mix.Config

# Configure your database
config :ui, Ui.Repo,
  adapter: Sqlite.Ecto2,
  database: "#{Mix.env}.sqlite3"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ui, UiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
