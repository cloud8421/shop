defmodule StoreTest do
  use ExUnit.Case

  setup [:empty_store, :insert_sample_product]

  test "it adds a product", %{product: product} do
    assert [{product.sku, product}] == :ets.lookup(Store, product.sku)
  end

  test "it lists products", %{product: product} do
    assert [product] == Store.all()
  end

  test "it finds a product", %{product: product} do
    assert {:ok, product} == Store.find(product.sku)
    assert {:error, :not_found} == Store.find("non-existing-sku")
  end

  defp empty_store(_context) do
    Store.clear()
  end

  defp insert_sample_product(_context) do
    product = Store.Product.new(%{sku: "p123", name: "Printer", description: "Some printer"})

    :ok = Store.insert(product)

    [product: product]
  end
end
