defmodule Front.Command.CreateProduct do
  def from_string_attrs(attrs, opts) do
    store = Keyword.fetch!(opts, :store)

    new_product =
      attrs
      |> whitelist
      |> Store.Product.new()

    :ok = Store.insert(store, new_product)

    {:ok, new_product}
  end

  defp whitelist(params) do
    %{
      sku: Map.get(params, "sku"),
      type: Map.get(params, "type"),
      name: Map.get(params, "name"),
      description: Map.get(params, "description")
    }
  end
end
