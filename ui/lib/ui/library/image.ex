defmodule Ui.Library.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :full_path_name, :string
    field :sequence_number, :integer
    belongs_to :volume, Ui.Library.Volume

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:sequence_number, :full_path_name])
    |> validate_required([:sequence_number, :full_path_name])
  end
end
