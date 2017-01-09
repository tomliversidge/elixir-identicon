defmodule Identicon do

  def generate(input) do
    input
    |> hash
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save(input)
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
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
     [a ,b | _tail] = row
     row ++ [b, a]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn ({value, _index}) ->
      rem(value, 2) == 0
    end
    %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn ({_value, index}) ->
      x = rem(index, 5) * 50
      y = div(index, 5) * 50
      top_left = {x, y}
      bottom_right = {x + 50, y + 50}
      {top_left, bottom_right}
    end
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    Enum.each pixel_map, fn ({top_left, bottom_right}) ->
      :egd.filledRectangle(image, top_left, bottom_right, fill)
    end
    :egd.render(image)
  end

  def save(binary, filename) do
    File.write("#{filename}.png", binary)
  end
end
