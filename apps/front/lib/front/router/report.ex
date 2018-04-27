defmodule Front.Router.Report do
  @moduledoc false

  use Plug.Router

  plug :match
  plug :dispatch

  get "/by_type/:type" do
    products = Store.by_type(type)

    send_resp(conn, 200, Jason.encode!(%{count: Enum.count(products)}))
  end
end
