defmodule Ui.Repo.Migrations.CreateVolumes do
  use Ecto.Migration

  def change do
    create table(:volumes) do
      add :name, :string
      add :volume_number, :integer
      add :repository_id, references(:repositories, on_delete: :delete_all)

      timestamps()
    end

    create index(:volumes, [:repository_id])
  end
end
