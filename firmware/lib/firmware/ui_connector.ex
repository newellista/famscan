defmodule Firmware.UiConnector do
  use WebSockex
  require Logger

  alias Firmware.ImageInfo

  def image_captured(client, %ImageInfo{} = image_info) do
    Logger.info("Sending ImageInfo: #{inspect image_info}")
    WebSockex.send_frame(client, image_info |> Jason.encode!())
  end

  def start_link(state) do
    url = Application.get_env(:firmware, :websocket_url)
    IO.inspect "Connecting to #{url}"
    WebSockex.start_link(url, __MODULE__, state, name: __MODULE__, async: true, handle_initial_conn_failure: true)
  end

  def handle_connect(_conn, state) do
    IO.inspect "Connected"
    Logger.info("Connected!")
    send self(), :join
    {:ok, state}
  end

  def handle_frame({:text, payload}, state) do
    message = payload |> Jason.decode!

    Logger.info("Received #{message["event"]} command")

    handle_message(message["event"], message["payload"])
    {:ok, state}
  end

  defp handle_message("preview", _msg), do: preview_image()
  defp handle_message("start_capture", msg), do: start_capture(msg)
  defp handle_message("end_capture", _msg), do: end_capture()
  defp handle_message(_event, _msg), do: :ok

  defp preview_image(), do: Firmware.MotionDetector.start_streaming()
  defp start_capture(_msg) do
  end
  defp end_capture() do
  end

  def handle_info(:join, state) do
    join_payload = %{
      payload: %{text: "Payload Text"},
      event: "phx_join",
      topic: "camera:control",
      ref: "lbkajldkfjawr",
      join_ref: "oijwpejpasfsf"
    } |> Jason.encode!()

    {:reply, {:text, join_payload}, state}
  end
end

