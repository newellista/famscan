defmodule Ui.ImageCaptureInfo do
  alias __MODULE__

  @derive {Jason.Encoder, only: [:path, :beginning_id, :width, :height, :image_type]}
  @enforce_keys [:path, :beginning_id, :width, :height]
  defstruct [:path, :beginning_id, :width, :height, :image_type]

  def new(path, beginning_id, width, height, image_type), do: %ImageCaptureInfo{path: path, beginning_id: beginning_id, width: width, height: height, image_type: image_type}
  def new(path, beginning_id, width, height), do: %ImageCaptureInfo{path: path, beginning_id: beginning_id, width: width, height: height, image_type: "jpg"}
end
