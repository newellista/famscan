defmodule UiWeb.CaptureController do
  use UiWeb, :controller

  alias Ui.Library

  def preview(_conn, _) do
  end

  def start_capture(_conn, %{"volume_id" => _volume_id}) do
  end

  def end_capture(_conn, %{"volume_id" => _volume_id}) do
  end
end
