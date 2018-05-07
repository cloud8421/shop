defmodule Front.Context do
  defstruct store: Store

  def new, do: %__MODULE__{}
  def new(attrs), do: struct(__MODULE__, attrs)
end
