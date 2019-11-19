defmodule Ui.LibraryTest do
  use Ui.DataCase

  alias Ui.Library

  describe "repositories" do
    alias Ui.Library.Repository

    @valid_attrs %{city: "some city", country: "some country", latitude: "some latitude", longitude: "some longitude", name: "some name", postal_code: "some postal_code", state: "some state", street_address: "some street_address"}
    @update_attrs %{city: "some updated city", country: "some updated country", latitude: "some updated latitude", longitude: "some updated longitude", name: "some updated name", postal_code: "some updated postal_code", state: "some updated state", street_address: "some updated street_address"}
    @invalid_attrs %{city: nil, country: nil, latitude: nil, longitude: nil, name: nil, postal_code: nil, state: nil, street_address: nil}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Library.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Library.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Library.create_repository(@valid_attrs)
      assert repository.city == "some city"
      assert repository.country == "some country"
      assert repository.latitude == "some latitude"
      assert repository.longitude == "some longitude"
      assert repository.name == "some name"
      assert repository.postal_code == "some postal_code"
      assert repository.state == "some state"
      assert repository.street_address == "some street_address"
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{} = repository} = Library.update_repository(repository, @update_attrs)
      assert repository.city == "some updated city"
      assert repository.country == "some updated country"
      assert repository.latitude == "some updated latitude"
      assert repository.longitude == "some updated longitude"
      assert repository.name == "some updated name"
      assert repository.postal_code == "some updated postal_code"
      assert repository.state == "some updated state"
      assert repository.street_address == "some updated street_address"
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_repository(repository, @invalid_attrs)
      assert repository == Library.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = Library.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> Library.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = Library.change_repository(repository)
    end
  end

  describe "contacts" do
    alias Ui.Library.Contact

    @valid_attrs %{email_address: "some email_address", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number", title: "some title"}
    @update_attrs %{email_address: "some updated email_address", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number", title: "some updated title"}
    @invalid_attrs %{email_address: nil, first_name: nil, last_name: nil, phone_number: nil, title: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Library.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Library.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Library.create_contact(@valid_attrs)
      assert contact.email_address == "some email_address"
      assert contact.first_name == "some first_name"
      assert contact.last_name == "some last_name"
      assert contact.phone_number == "some phone_number"
      assert contact.title == "some title"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{} = contact} = Library.update_contact(contact, @update_attrs)
      assert contact.email_address == "some updated email_address"
      assert contact.first_name == "some updated first_name"
      assert contact.last_name == "some updated last_name"
      assert contact.phone_number == "some updated phone_number"
      assert contact.title == "some updated title"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_contact(contact, @invalid_attrs)
      assert contact == Library.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Library.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Library.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Library.change_contact(contact)
    end
  end

  describe "volumes" do
    alias Ui.Library.Volume

    @valid_attrs %{name: "some name", volume_number: 42}
    @update_attrs %{name: "some updated name", volume_number: 43}
    @invalid_attrs %{name: nil, volume_number: nil}

    def volume_fixture(attrs \\ %{}) do
      {:ok, volume} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_volume()

      volume
    end

    test "list_volumes/0 returns all volumes" do
      volume = volume_fixture()
      assert Library.list_volumes() == [volume]
    end

    test "get_volume!/1 returns the volume with given id" do
      volume = volume_fixture()
      assert Library.get_volume!(volume.id) == volume
    end

    test "create_volume/1 with valid data creates a volume" do
      assert {:ok, %Volume{} = volume} = Library.create_volume(@valid_attrs)
      assert volume.name == "some name"
      assert volume.volume_number == 42
    end

    test "create_volume/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_volume(@invalid_attrs)
    end

    test "update_volume/2 with valid data updates the volume" do
      volume = volume_fixture()
      assert {:ok, %Volume{} = volume} = Library.update_volume(volume, @update_attrs)
      assert volume.name == "some updated name"
      assert volume.volume_number == 43
    end

    test "update_volume/2 with invalid data returns error changeset" do
      volume = volume_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_volume(volume, @invalid_attrs)
      assert volume == Library.get_volume!(volume.id)
    end

    test "delete_volume/1 deletes the volume" do
      volume = volume_fixture()
      assert {:ok, %Volume{}} = Library.delete_volume(volume)
      assert_raise Ecto.NoResultsError, fn -> Library.get_volume!(volume.id) end
    end

    test "change_volume/1 returns a volume changeset" do
      volume = volume_fixture()
      assert %Ecto.Changeset{} = Library.change_volume(volume)
    end
  end

  describe "images" do
    alias Ui.Library.Image

    @valid_attrs %{full_path_name: "some full_path_name", sequence_number: 42}
    @update_attrs %{full_path_name: "some updated full_path_name", sequence_number: 43}
    @invalid_attrs %{full_path_name: nil, sequence_number: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Library.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Library.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Library.create_image(@valid_attrs)
      assert image.full_path_name == "some full_path_name"
      assert image.sequence_number == 42
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, %Image{} = image} = Library.update_image(image, @update_attrs)
      assert image.full_path_name == "some updated full_path_name"
      assert image.sequence_number == 43
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_image(image, @invalid_attrs)
      assert image == Library.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Library.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Library.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Library.change_image(image)
    end
  end
end
