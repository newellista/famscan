defmodule UiWeb.RepositoryControllerTest do
  use UiWeb.ConnCase

  alias Ui.Library

  @create_attrs %{city: "some city", country: "some country", latitude: "some latitude", longitude: "some longitude", name: "some name", postal_code: "some postal_code", state: "some state", street_address: "some street_address"}
  @update_attrs %{city: "some updated city", country: "some updated country", latitude: "some updated latitude", longitude: "some updated longitude", name: "some updated name", postal_code: "some updated postal_code", state: "some updated state", street_address: "some updated street_address"}
  @invalid_attrs %{city: nil, country: nil, latitude: nil, longitude: nil, name: nil, postal_code: nil, state: nil, street_address: nil}

  def fixture(:repository) do
    {:ok, repository} = Library.create_repository(@create_attrs)
    repository
  end

  describe "index" do
    test "lists all repositories", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repositories"
    end
  end

  describe "new repository" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :new))
      assert html_response(conn, 200) =~ "New Repository"
    end
  end

  describe "create repository" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.repository_path(conn, :create), repository: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.repository_path(conn, :show, id)

      conn = get(conn, Routes.repository_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Repository"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.repository_path(conn, :create), repository: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Repository"
    end
  end

  describe "edit repository" do
    setup [:create_repository]

    test "renders form for editing chosen repository", %{conn: conn, repository: repository} do
      conn = get(conn, Routes.repository_path(conn, :edit, repository))
      assert html_response(conn, 200) =~ "Edit Repository"
    end
  end

  describe "update repository" do
    setup [:create_repository]

    test "redirects when data is valid", %{conn: conn, repository: repository} do
      conn = put(conn, Routes.repository_path(conn, :update, repository), repository: @update_attrs)
      assert redirected_to(conn) == Routes.repository_path(conn, :show, repository)

      conn = get(conn, Routes.repository_path(conn, :show, repository))
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, repository: repository} do
      conn = put(conn, Routes.repository_path(conn, :update, repository), repository: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Repository"
    end
  end

  describe "delete repository" do
    setup [:create_repository]

    test "deletes chosen repository", %{conn: conn, repository: repository} do
      conn = delete(conn, Routes.repository_path(conn, :delete, repository))
      assert redirected_to(conn) == Routes.repository_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.repository_path(conn, :show, repository))
      end
    end
  end

  defp create_repository(_) do
    repository = fixture(:repository)
    {:ok, repository: repository}
  end
end
