defmodule Firmware.Camera do

  def initialize_camera() do
    set_resolution(3280, 0)
    set_quality(100)
  end

  def set_resolution(width \\ 3280, height \\ 0), do: Picam.set_size(3280, height)
  def set_quality(quality \\ 15), do: Picam.set_quality(quality)

  def take_picture(new_filename) do
    File.write!(new_filename, Picam.next_frame)
  end
end
