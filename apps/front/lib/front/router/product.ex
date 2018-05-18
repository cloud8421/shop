defmodule Front.Router.Product do
  @moduledoc false

  alias Front.Command.CreateProduct

  use Plug.Router

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  plug Front.AssignStore
  plug :match
  plug :dispatch

  get "/" do
    store = conn.private[:store]

    products = Store.all(store)

    send_resp(conn, 200, Jason.encode!(products))
  end

  post "/" do
    store = conn.private[:store]

    {:ok, new_product} = CreateProduct.from_string_attrs(conn.body_params, store: store)
    send_resp(conn, 201, Jason.encode!(%{sku: new_product.sku}))
  end
end
