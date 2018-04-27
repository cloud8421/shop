defmodule Front.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Front.Router, as: R

  @opts R.init([])

  test "GET /hello" do
    conn =
      conn(:get, "/hello")
      |> R.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "world"
  end

  test "GET /non-existing" do
    conn =
      conn(:get, "/non-existing")
      |> R.call(@opts)

    assert conn.status == 404
    assert conn.resp_body == "not found"
  end
end
