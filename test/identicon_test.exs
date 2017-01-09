defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "string to number array" do
    assert Identicon.hash("hello world") ==
      %Identicon.Image{hex: [94, 182, 59, 187, 224, 30, 238, 208, 147, 203,
             34, 187, 143, 90, 205, 195]}
  end

  test "color pick takes first 3 items from hex as RGB" do
    assert Identicon.pick_color(%Identicon.Image{hex: [1,2,3,4,5]}) ==
      %Identicon.Image{color: {1,2,3}, hex: [1,2,3,4,5]}
  end
end
