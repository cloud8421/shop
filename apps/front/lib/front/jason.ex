defmodule Front.Jason do
  require Protocol

  Protocol.derive(Jason.Encoder, Store.Product)
end
