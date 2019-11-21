defmodule Ui.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias Ui.Repo

  alias Ui.Library.{Repository, Volume, Contact, Image}

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories do
    Repo.all(Repository)
  end

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id) do
    Repository
    |> Repo.get!(id)
    |> Repo.preload(:contacts)
    |> Repo.preload(:volumes)
  end

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> Repository.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{source: %Repository{}}

  """
  def change_repository(%Repository{} = repository) do
    Repository.changeset(repository, %{})
  end

  alias Ui.Library.Contact

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contact{}, ...]

  """
  def list_contacts do
    Repo.all(Contact)
  end

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact!(id), do: Repo.get!(Contact, id)

  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact(%Repository{} = repository, attrs \\ %{}) do
    repository
    |> Ecto.build_assoc(:contacts)
    |> Contact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contact.

  ## Examples

      iex> update_contact(contact, %{field: new_value})
      {:ok, %Contact{}}

      iex> update_contact(contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact(%Contact{} = contact, attrs) do
    contact
    |> Contact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Contact.

  ## Examples

      iex> delete_contact(contact)
      {:ok, %Contact{}}

      iex> delete_contact(contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{source: %Contact{}}

  """
  def change_contact(%Contact{} = contact) do
    Contact.changeset(contact, %{})
  end

  alias Ui.Library.Volume

  @doc """
  Returns the list of volumes.

  ## Examples

      iex> list_volumes()
      [%Volume{}, ...]

  """
  def list_volumes do
    Volume
    |> Repo.all
    |> Repo.preload(:repository)
  end

  @doc """
  Gets a single volume.

  Raises `Ecto.NoResultsError` if the Volume does not exist.

  ## Examples

      iex> get_volume!(123)
      %Volume{}

      iex> get_volume!(456)
      ** (Ecto.NoResultsError)

  """
  def get_volume!(id) do

    Volume
    |> Repo.get!(id)
  end

  @doc """
  Creates a volume.

  ## Examples

      iex> create_volume(%{field: value})
      {:ok, %Volume{}}

      iex> create_volume(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_volume(%Repository{} = repository, attrs \\ %{}) do
    repository
    |> Ecto.build_assoc(:volumes)
    |> Volume.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a volume.

  ## Examples

      iex> update_volume(volume, %{field: new_value})
      {:ok, %Volume{}}

      iex> update_volume(volume, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_volume(%Volume{} = volume, attrs) do
    volume
    |> Volume.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Volume.

  ## Examples

      iex> delete_volume(volume)
      {:ok, %Volume{}}

      iex> delete_volume(volume)
      {:error, %Ecto.Changeset{}}

  """
  def delete_volume(%Volume{} = volume) do
    Repo.delete(volume)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking volume changes.

  ## Examples

      iex> change_volume(volume)
      %Ecto.Changeset{source: %Volume{}}

  """
  def change_volume(%Volume{} = volume) do
    Volume.changeset(volume, %{})
  end

  alias Ui.Library.Image

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  @doc """
  Gets the next sequence id for an image

  ## Examples

    iex> get_next_image_sequence()
    {:ok, 1234}

    # On error
    iex> get_next_image_sequence()
    {:error, "Unable to generate sequence number"}

  """
  def get_next_image_sequence() do
    last_image = Repo.one(from x in Image, order_by: [desc: x.id], limit: 1)

    case last_image do
      nil ->
        {:ok, 1}
      _ ->
        {:ok, last_image.id + 1}
    end
  end

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{source: %Image{}}

  """
  def change_image(%Image{} = image) do
    Image.changeset(image, %{})
  end
end
