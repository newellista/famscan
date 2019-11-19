defmodule UiWeb.VolumeController do
  use UiWeb, :controller

  alias Ui.Library

  def create(conn, %{"repository_id" => repository_id, "volume" => volume_params}) do
    repository = Library.get_repository!(repository_id)

    case Library.create_volume(repository, volume_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Volume created successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do

  end

  def show(conn, %{"id" => id}) do

  end
end

