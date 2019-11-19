defmodule UiWeb.RepositoryController do
  use UiWeb, :controller

  alias Ui.Library
  alias Ui.Library.{Contact, Repository, Volume}

  def index(conn, _params) do
    repositories = Library.list_repositories()
    render(conn, "index.html", repositories: repositories)
  end

  def new(conn, _params) do
    changeset = Library.change_repository(%Repository{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repository" => repository_params}) do
    case Library.create_repository(repository_params) do
      {:ok, repository} ->
        conn
        |> put_flash(:info, "Repository created successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    repository = Library.get_repository!(id)
    contact_changeset = Library.change_contact(%Contact{})
    volume_changeset = Library.change_volume(%Volume{})
    render(conn, "show.html", repository: repository, contact_changeset: contact_changeset, volume_changeset: volume_changeset)
  end

  def edit(conn, %{"id" => id}) do
    repository = Library.get_repository!(id)
    changeset = Library.change_repository(repository)
    render(conn, "edit.html", repository: repository, changeset: changeset)
  end

  def update(conn, %{"id" => id, "repository" => repository_params}) do
    repository = Library.get_repository!(id)

    case Library.update_repository(repository, repository_params) do
      {:ok, repository} ->
        conn
        |> put_flash(:info, "Repository updated successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", repository: repository, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repository = Library.get_repository!(id)
    {:ok, _repository} = Library.delete_repository(repository)

    conn
    |> put_flash(:info, "Repository deleted successfully.")
    |> redirect(to: Routes.repository_path(conn, :index))
  end
end
