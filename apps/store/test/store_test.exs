defmodule StoreTest do
  use ExUnit.Case, async: true

  setup [:empty_store, :insert_sample_product]

  test "it adds a product", %{product: product} do
    assert [{product.sku, product}] == :ets.lookup(Store, product.sku)
  end

  test "it lists all products", %{product: product} do
    assert [product] == Store.all()
  end

  test "it filters products by type", %{product: product} do
    assert [product] == Store.by_type("computer_accessory")
    assert [] == Store.by_type("kitchen_appliance")
  end

  test "it finds a product", %{product: product} do
    assert {:ok, product} == Store.find(product.sku)
    assert {:error, :not_found} == Store.find("non-existing-sku")
  end

  defp empty_store(_context) do
    Store.clear()
  end

  defp insert_sample_product(_context) do
    product =
      Store.Product.new(%{
        sku: "p123",
        type: "computer_accessory",
        name: "Printer",
        description: "Some printer"
      })

    :ok = Store.insert(product)

    [product: product]
  end
end
