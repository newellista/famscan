defmodule UiWeb.VolumeController do
  use UiWeb, :controller

  alias Ui.Library

  def create(conn, %{"repository_id" => repository_id, "volume" => volume_params}) do
    repository = Library.get_repository!(repository_id)

    case Library.create_volume(repository, volume_params) do
      {:ok, _volume} ->
        conn
        |> put_flash(:info, "Volume created successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    volumes = Library.list_volumes()
    render(conn, "index.html", volumes: volumes)
  end

  def show(conn, %{"id" => id}) do
    volume = Library.get_volume!(id)
    render(conn, "show.html", volume: volume)
  end

  def delete(conn, %{"id" => id}) do
    volume = Library.get_volume!(id)
    {:ok, _repository} = Library.delete_volume(volume)

    conn
    |> put_flash(:info, "Volume deleted successfully.")
    |> redirect(to: Routes.volume_path(conn, :index))
  end
end

