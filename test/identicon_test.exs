defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "string to number array" do
    assert Identicon.generate("hello world") == [94, 182, 59, 187, 224, 30, 238, 208, 147, 203, 34, 187, 143, 90, 205, 195]
  end
end
