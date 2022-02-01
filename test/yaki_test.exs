defmodule YakiTest do
  use ExUnit.Case
  doctest Yaki

  test "greets the world" do
    assert Yaki.hello() == :world
  end
end
