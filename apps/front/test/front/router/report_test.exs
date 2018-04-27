defmodule Front.Router.ReportTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router.Report, as: R

  @opts R.init([])

  setup [:insert_products]

  test "GET /by_type/:type" do
    conn =
      conn(:get, "/by_type/computer_accessory")
      |> R.call(@opts)

    assert conn.status == 200

    assert conn.resp_body == ~s({"count":1})
  end

  defp insert_products(_context) do
    Store.clear()

    product_one =
      Store.Product.new(%{
        sku: "p123",
        type: "computer_accessory",
        name: "Printer",
        description: "Some printer"
      })

    product_two =
      Store.Product.new(%{
        sku: "p456",
        type: "kitchen_appliance",
        name: "Oven",
        description: "Some printer"
      })

    :ok = Store.insert(product_one)
    :ok = Store.insert(product_two)
  end
end
