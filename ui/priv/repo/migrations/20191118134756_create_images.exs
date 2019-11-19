defmodule Ui.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :sequence_number, :integer
      add :full_path_name, :string
      add :volume_id, references(:volumes, on_delete: :delete_all)

      timestamps()
    end

    create index(:images, [:volume_id])
  end
end
