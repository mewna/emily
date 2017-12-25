defmodule EmilyTest do
  use ExUnit.Case
  doctest Emily

  test "greets the world" do
    assert Emily.hello() == :world
  end
end
