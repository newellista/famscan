use Mix.Config

config :ui, Ui.Repo,
  adapter: Sqlite.Ecto2,
  database: "/root/#{Mix.env}.sqlite3"
