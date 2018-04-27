defmodule FrontTest do
  use ExUnit.Case
  doctest Front

  test "greets the world" do
    assert Front.hello() == :world
  end
end
