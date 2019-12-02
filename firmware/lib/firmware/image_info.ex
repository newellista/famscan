defmodule Firmware.ImageInfo do
  @derive Jason.Encoder

  @enforce_keys [:image_name, :image_location, :volume_id, :image_size]
  defstruct [:volume_id, image_name: "", image_location: "/root", image_size: 0, status: :ok]

end
