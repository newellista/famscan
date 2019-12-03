defmodule Firmware.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  require Logger
  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Firmware.Supervisor]
    port = Application.get_env(:firmware, :port)
    Logger.info "Port: #{port}"

    maybe_enable_wizard()

    children =
      [
        # Plug.Adapters.Cowboy.child_spec(:http, Firmware.Router, [], port: port)
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Firmware.Worker.start_link(arg)
      # {Firmware.Worker, arg},
    ]
  end

  def children(_target) do
    [
      {Picam.Camera, []},
      {Firmware.MotionDetector, []},
      {Firmware.UiConnector, []},
      # Children for all targets except host
      # Starts a worker by calling: Firmware.Worker.start_link(arg)
      # {Firmware.Worker, arg},
    ]
  end

  def maybe_enable_wizard() do
    configured = VintageNet.configured_interfaces()
    all = VintageNet.all_interfaces()

    with true <- "wlan0" in all,
         true <- "wlan0" not in configured
    do
      VintageNetWizard.run_wizard()
    end
  end

  def target() do
    Application.get_env(:firmware, :target)
  end
end
