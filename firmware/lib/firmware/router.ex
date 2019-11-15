defmodule Firmware.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/test" do
    markup = """
    <html>
    <head>
      <title>FamScan Video Stream</title>
    </head>
    <body>
      <img src="video.mjpg" />
    <form action="/reset" method="POST">
      <button type="button">Reset motion sensor</button>
    </form>
    </body>
    </html>
    """

    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(200, markup)
  end

  post "/reset" do
    markup = """
    <html>
    <head>
      <title>FamScan Video Stream</title>
    </head>
    <body>
      <form action="/reset" method="POST">
        <button type="button">Reset motion sensor</button>
      </form>
    </body>
    </html>
    """

    GenServer.cast(MotionDetector, :reset)

    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(200, markup)
  end

  forward("/video.mjpg", to: Firmware.Streamer)

  match _ do
    send_resp(conn, 404, "Oops. Try /")
  end
end
