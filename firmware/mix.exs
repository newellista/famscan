defmodule Firmware.MixProject do
  use Mix.Project

  @app :firmware
  @version "0.1.0"
  @all_targets [:rpi, :rpi0, :rpi0_ffmpeg, :rpi2, :rpi3, :rpi3a, :rpi4, :bbb, :x86_64]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.9",
      archives: [nerves_bootstrap: "~> 1.6"],
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host]
    ]
  end

  # Starting nerves_bootstrap adds the required aliases to Mix.Project.config()
  # Aliases are only added if MIX_TARGET is set.
  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Firmware.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Dependencies for all targets
      {:nerves, "~> 1.5.0", runtime: false},
      {:shoehorn, "~> 0.6"},
      {:ring_logger, "~> 0.6"},
      {:toolshed, "~> 0.2"},
      {:cowboy, "~> 2.5"},
      {:plug, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:ex_image_info, "~> 0.2.4"},
      {:picam, git: "https://github.com/newellista/picam.git", nerves: [compile: true]},
      {:httpoison, "~> 0.8"},
      {:jason, "~> 1.1"},
      {:poison, "~> 3.0"},
      {:hackney, "~> 1.9"},
      {:websockex, "~> 0.4.2"},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.6", targets: @all_targets},
      {:vintage_net, "~> 0.3", targets: @all_targets},
      {:vintage_net_wizard, "~> 0.1", targets: @all_targets},
      {:busybox, "~> 0.1", targets: @all_targets},
      {:nerves_firmware_ssh, "~> 0.2", targets: @all_targets},
      {:nerves_pack, "~> 0.1.0", targets: @all_targets},
      {:nerves_time, "~> 0.2", targets: @all_targets},
      {:mdns_lite, "~> 0.4", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.8", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.8", runtime: false, targets: :rpi0},
      {:rpi0_ffmpeg, path: "../../rpi0_ffmpeg", runtime: false, targets: :rpi0_ffmpeg, nerves: [compile: true]},
      {:nerves_system_rpi2, "~> 1.8", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.8", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.8", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.8", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.3", runtime: false, targets: :bbb},
      {:nerves_system_x86_64, "~> 1.8", runtime: false, targets: :x86_64},
    ]
  end

  def release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod
    ]
  end
end
