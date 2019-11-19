defmodule UiWeb.ContactController do
  use UiWeb, :controller

  alias Ui.Library

  def create(conn, %{"repository_id" => repository_id, "contact" => contact_params}) do
    repository = Library.get_repository!(repository_id)

    case Library.create_contact(repository, contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact created successfully.")
        |> redirect(to: Routes.repository_path(conn, :show, repository))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
