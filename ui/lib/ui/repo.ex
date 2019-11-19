defmodule Ui.Repo do
  use Ecto.Repo,
    otp_app: :ui,
    adapter: Sqlite.Ecto2
end
