defmodule Front.Router.ProductTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router.Product, as: R

  @opts R.init([])

  test "GET /" do
    Store.clear()

    conn =
      get("/")
      |> R.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "[]"
  end

  test "GET / with products" do
    Store.clear()

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

    :ok = Store.insert(product_one)
    :ok = Store.insert(product_two)

    conn =
      get("/")
      |> R.call(@opts)

    assert conn.status == 200

    assert conn.resp_body ==
             ~s([{"description":"Some printer","name":"Printer-two","sku":"p456","type":"kitchen_appliance"},{"description":"Some printer","name":"Printer-one","sku":"p123","type":"computer_accessory"}])
  end

  test "POST /" do
    params = %{
      "sku" => "p456",
      "type" => "kitchen_appliance",
      "name" => "Printer-two",
      "description" => "Some printer"
    }

    conn =
      post("/", params)
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
end
