defmodule Front.Router.Product do
  @moduledoc false

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

    new_product =
      conn.body_params
      |> whitelist_params
      |> Store.Product.new()

    :ok = Store.insert(store, new_product)
    send_resp(conn, 201, Jason.encode!(%{sku: new_product.sku}))
  end

  defp whitelist_params(params) do
    %{
      sku: Map.get(params, "sku"),
      type: Map.get(params, "type"),
      name: Map.get(params, "name"),
      description: Map.get(params, "description")
    }
  end
end
