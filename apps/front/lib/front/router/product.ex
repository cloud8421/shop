defmodule Front.Router.Product do
  @moduledoc false

  alias Front.Command.CreateProduct

  use Plug.Router

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  plug :match
  plug :dispatch

  get "/" do
    context = conn.private[:context]

    products = Store.all(context.store)

    send_resp(conn, 200, Jason.encode!(products))
  end

  post "/" do
    context = conn.private[:context]

    {:ok, new_product} = CreateProduct.from_string_attrs(conn.body_params, context)
    send_resp(conn, 201, Jason.encode!(%{sku: new_product.sku}))
  end
end
