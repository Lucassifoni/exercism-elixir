defmodule StringSeries do
  def slices(s, size) when size < 1, do: []
  def slices(s, size), do: if size > String.length(s), do: [], else: rslices(s, size, [], 0) |> Enum.reverse

  def rslices(s, size, acc, n) do
    case String.slice(s, n, size) do
      "" -> acc
      a -> if String.length(a) < size, do: acc, else: rslices(s, size, [a | acc], n + 1)
    end
  end
end
