defmodule Identicon do
  def generate(input) do
      input
      |> hash
  end

  defp hash(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end

end
