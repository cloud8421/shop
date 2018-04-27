defmodule Store do
  @moduledoc """
  Provides a in-memory, ETS backed product store.
  """

  @spec create_table :: :ok | no_return
  def create_table do
    __MODULE__ = :ets.new(__MODULE__, [:public, :named_table, read_concurrency: true])
    :ok
  end

  @spec clear :: :ok | no_return
  def clear do
    true = :ets.delete_all_objects(__MODULE__)
    :ok
  end

  @spec insert(Store.Product.t()) :: :ok | no_return
  def insert(product) do
    true = :ets.insert(__MODULE__, {product.sku, product})
    :ok
  end

  @spec find(Store.Product.sku()) :: {:ok, Store.Product.t()} | {:error, :not_found}
  def find(sku) do
    case :ets.lookup(__MODULE__, sku) do
      [{^sku, product}] -> {:ok, product}
      _ -> {:error, :not_found}
    end
  end

  @spec all :: [Store.Product.t()]
  def all do
    __MODULE__
    |> :ets.tab2list()
    |> Keyword.values()
  end

  @spec by_type(Store.Product.type()) :: [Store.Product.t()]
  def by_type(type) do
    spec = [
      {
        {:_, %{type: type}},
        [],
        [{:element, 2, :"$_"}]
      }
    ]

    :ets.select(__MODULE__, spec)
  end
end
