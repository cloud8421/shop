defmodule Front.Router.Product do
  @moduledoc false

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    products = Store.all()

    send_resp(conn, 200, Jason.encode!(products))
  end
end
