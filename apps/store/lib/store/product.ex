defmodule Store.Product do
  @moduledoc """
  Defines a unique item in the product database
  """

  defstruct sku: nil,
            type: nil,
            name: nil,
            description: nil

  @type sku :: String.t()

  @type t :: %__MODULE__{
          sku: nil | sku,
          type: nil | String.t(),
          name: nil | String.t(),
          description: nil | String.t()
        }

  @spec new(%{optional(atom) => term()}) :: t
  def new(attrs) do
    struct(__MODULE__, attrs)
  end
end
