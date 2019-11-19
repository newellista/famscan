defmodule Ui.Library.Volume do
  use Ecto.Schema
  import Ecto.Changeset

  schema "volumes" do
    field :name, :string
    field :volume_number, :integer
    belongs_to :repository, Ui.Library.Repository

    timestamps()
  end

  @doc false
  def changeset(volume, attrs) do
    volume
    |> cast(attrs, [:name, :volume_number])
    |> validate_required([:name, :volume_number])
  end
end
