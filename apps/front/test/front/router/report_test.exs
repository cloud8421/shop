defmodule Front.Router.ReportTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router.Report, as: R
  alias Front.Plug.Context

  @opts R.init([])

  setup [:create_test_store, :insert_products]

  test "GET /by_type/:type", %{store: store} do
    conn =
      conn(:get, "/by_type/computer_accessory")
      |> Context.with_overrides(store: store)
      |> R.call(@opts)

    assert conn.status == 200

    assert conn.resp_body == ~s({"count":1})
  end

  defp create_test_store(_context) do
    store = Store.create_test_table()

    [store: store]
  end

  defp insert_products(context) do
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

    :ok = Store.insert(context.store, product_one)
    :ok = Store.insert(context.store, product_two)
  end
end
