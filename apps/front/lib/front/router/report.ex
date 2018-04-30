defmodule Front.Router.Report do
  @moduledoc false

  use Plug.Router

  plug Front.AssignStore
  plug :match
  plug :dispatch

  get "/by_type/:type" do
    store = conn.private[:store]
    products = Store.by_type(store, type)

    send_resp(conn, 200, Jason.encode!(%{count: Enum.count(products)}))
  end
end
