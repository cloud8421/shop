defmodule Front.Router.ProductTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router.Product, as: R

  @opts R.init([])

  test "GET /" do
    Store.clear()

    conn =
      conn(:get, "/")
      |> R.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "[]"
  end
end
