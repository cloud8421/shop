defmodule Store do
  @moduledoc """
  Provides a in-memory, ETS backed product store.
  """

  @type table :: :ets.tid() | atom

  @spec create_table :: :ok | no_return
  def create_table do
    __MODULE__ = :ets.new(__MODULE__, [:public, :named_table, read_concurrency: true])
    :ok
  end

  @spec create_test_table :: table()
  def create_test_table do
    :ets.new(__MODULE__, read_concurrency: true)
  end

  @spec clear(table()) :: :ok | no_return
  def clear(table \\ __MODULE__) do
    true = :ets.delete_all_objects(table)
    :ok
  end

  @spec insert(table(), Store.Product.t()) :: :ok | no_return
  def insert(table \\ __MODULE__, product) do
    true = :ets.insert(table, {product.sku, product})
    :ok
  end

  @spec find(table(), Store.Product.sku()) :: {:ok, Store.Product.t()} | {:error, :not_found}
  def find(table \\ __MODULE__, sku) do
    case :ets.lookup(table, sku) do
      [{^sku, product}] -> {:ok, product}
      _ -> {:error, :not_found}
    end
  end

  @spec all(table()) :: [Store.Product.t()]
  def all(table \\ __MODULE__) do
    table
    |> :ets.tab2list()
    |> Keyword.values()
  end

  @spec by_type(table(), Store.Product.t()) :: [Store.Product.t()]
  def by_type(table \\ __MODULE__, type) do
    spec = [
      {
        {:_, %{type: type}},
        [],
        [{:element, 2, :"$_"}]
      }
    ]

    :ets.select(table, spec)
  end
end
