defmodule Front.Router.ProductTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router.Product, as: R

  @opts R.init([])

  setup [:create_test_store]

  test "GET /", %{store: store} do
    conn =
      get("/")
      |> put_private(:store, store)
      |> R.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "[]"
  end

  test "GET / with products", %{store: store} do
    product_one =
      Store.Product.new(%{
        sku: "p123",
        type: "computer_accessory",
        name: "Printer-one",
        description: "Some printer"
      })

    product_two =
      Store.Product.new(%{
        sku: "p456",
        type: "kitchen_appliance",
        name: "Printer-two",
        description: "Some printer"
      })

    :ok = Store.insert(store, product_one)
    :ok = Store.insert(store, product_two)

    conn =
      get("/")
      |> put_private(:store, store)
      |> R.call(@opts)

    assert conn.status == 200

    assert conn.resp_body ==
             ~s([{"description":"Some printer","name":"Printer-two","sku":"p456","type":"kitchen_appliance"},{"description":"Some printer","name":"Printer-one","sku":"p123","type":"computer_accessory"}])
  end

  test "POST /", %{store: store} do
    params = %{
      "sku" => "p456",
      "type" => "kitchen_appliance",
      "name" => "Printer-two",
      "description" => "Some printer"
    }

    conn =
      post("/", params)
      |> put_private(:store, store)
      |> R.call(@opts)

    assert conn.status == 201
    assert conn.resp_body == ~s({"sku":"p456"})
  end

  defp post(path, params) do
    conn(:post, path, Jason.encode!(params))
    |> put_req_header("content-type", "application/json")
  end

  defp get(path) do
    conn(:get, path)
    |> put_req_header("content-type", "application/json")
  end

  defp create_test_store(_context) do
    store = Store.create_test_table()

    [store: store]
  end
end
