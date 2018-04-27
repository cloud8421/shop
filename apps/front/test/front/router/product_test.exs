defmodule Front.Router.ProductTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router.Product, as: R

  @opts R.init([])

  test "GET /" do
    Store.clear()

    conn =
      conn(:get, "/")
      |> R.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "[]"
  end

  test "GET / with products" do
    Store.clear()

    product_one =
      Store.Product.new(%{sku: "p123", name: "Printer-one", description: "Some printer"})

    product_two =
      Store.Product.new(%{sku: "p456", name: "Printer-two", description: "Some printer"})

    :ok = Store.insert(product_one)
    :ok = Store.insert(product_two)

    conn =
      conn(:get, "/")
      |> R.call(@opts)

    assert conn.status == 200

    assert conn.resp_body ==
             ~s([{"description":"Some printer","name":"Printer-two","sku":"p456"},{"description":"Some printer","name":"Printer-one","sku":"p123"}])
  end
end
