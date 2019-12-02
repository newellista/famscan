defmodule UiWeb.CameraControllerChannel do
  use UiWeb, :channel

  alias Ui.ImageCaptureInfo

  def join("camera:control", payload, socket) do
    Process.flag(:trap_exit, true)
    send(self(), {:after_join, payload})
    IO.inspect "Joined the control channel with #{inspect payload}"
    {:ok, socket}
  end

  def preview_capture() do
    UiWeb.Endpoint.broadcast("camera:control", "preview", %{})
  end
  def begin_capture(%ImageCaptureInfo{} = image_capture_info), do: UiWeb.Endpoint.broadcast("camera:control", "start_capture", image_capture_info)
  def end_capture(), do: UiWeb.Endpoint.broadcast("camera:control", "end_capture", %{})

  def handle_info({:after_join, %{} = payload}, socket) do
    IO.inspect "after_join: #{inspect payload}"
    push(socket, "join", %{status: "connected"})
    {:noreply, socket}
  end
  def handle_info(:preview, socket) do
    IO.inspect "Sending preview request"
    push(socket, "camera:control", %{text: "preview"})
    {:noreply, socket}
  end
  def handle_info(msg, socket) do
    IO.inspect "received: #{inspect msg}"
    {:noreply, socket}
  end

  def handle_in({:text, payload}, socket) do
    IO.inspect "msg: TEXT, payload: #{inspect payload}"
    {:noreply, socket}
  end
end
