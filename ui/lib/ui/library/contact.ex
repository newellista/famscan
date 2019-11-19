defmodule Ui.Library.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :title, :string
    belongs_to :repository, Ui.Library.Repository

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:first_name, :last_name, :title, :email_address, :phone_number])
    |> validate_required([:first_name, :last_name])
  end
end
