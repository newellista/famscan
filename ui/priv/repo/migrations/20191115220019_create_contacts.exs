defmodule Ui.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :first_name, :string
      add :last_name, :string
      add :title, :string
      add :email_address, :string
      add :phone_number, :string
      add :repository_id, references(:repositories, on_delete: :delete_all)

      timestamps()
    end

    create index(:contacts, [:repository_id])
  end
end
