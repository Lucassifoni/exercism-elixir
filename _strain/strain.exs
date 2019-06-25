defmodule Strain do
  def keep(list, fun), do: list |> Enum.reverse |> Enum.reduce([], fn i, acc -> if fun.(i), do: [i | acc], else: acc end)
  def discard(list, fun), do: list |> Enum.reverse |> Enum.reduce([], fn i, acc -> if fun.(i), do: acc, else: [i | acc] end)
end
