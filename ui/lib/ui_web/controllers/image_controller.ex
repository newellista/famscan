defmodule UiWeb.ImageController do
  use UiWeb, :controller

  alias Ui.Library
  alias Ui.Library.Image

  def index(_conn, _params) do
  end

  def show(conn, %{"id" => id}) do
    image = Library.get_image!(id)
    render(conn, "show.html", image: image)
  end
end
