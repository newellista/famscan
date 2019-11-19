defmodule Ui.Library.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repositories" do
    field :city, :string
    field :country, :string
    field :latitude, :string
    field :longitude, :string
    field :name, :string
    field :postal_code, :string
    field :state, :string
    field :street_address, :string

    has_many :contacts, Ui.Library.Contact
    has_many :volumes, Ui.Library.Volume
    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :street_address, :city, :state, :postal_code, :country, :latitude, :longitude])
    |> validate_required([:name, :street_address, :city, :state, :postal_code, :country])
  end
end
