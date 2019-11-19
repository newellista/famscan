defmodule Ui.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string
      add :street_address, :string
      add :city, :string
      add :state, :string
      add :postal_code, :string
      add :country, :string
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end

  end
end
