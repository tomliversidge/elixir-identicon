defmodule Identicon do

  def generate(input) do
    input
    |> hash
    |> pick_color
    |> build_grid
  end

  def hash(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
     [a ,b | _tail] = row
     row ++ [b, a]
  end
end
