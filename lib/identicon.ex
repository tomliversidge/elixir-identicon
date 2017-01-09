defmodule Identicon do

  def generate(input) do
    input
    |> hash
    |> pick_color
  end

  def hash(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    
    %Identicon.Image{image | color: {r, g, b}}
  end

end
