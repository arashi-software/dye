defmodule DyeTest do
  use ExUnit.Case
  doctest Dye

  test "greets the world" do
    assert Dye.hello() == :world
  end
end
