defmodule Minesweeper do
  def annotate([]), do: []
  def annotate(board) do
    h = length(board)
    {l, w} = list2_1(board)
    Enum.reduce(0..(w * h), l, fn i, a -> xy(Enum.at(a, i), a, i, w, h) end)
      |> list1_2(w)
      |> Enum.map(fn a -> Enum.reduce(a, "", &(to_string(&1) <> &2)) end)
  end

  defp xy("*", l, i, w, h) do
    {x, y} = dim1_2(i, w)
    cond do
      w == 1 -> l |> y(i, w, h, y) |> y(i + 1, w, h, y)
      x == 0 -> l |> up(i + 1) |> y(i, w, h, y) |> y(i + 1, w, h, y)
      x == (w - 1) -> l |> up(i - 1) |> y(i, w, h, y) |> y(i - 1, w, h, y)
      true -> up(l, i - 1) |> up(i + 1) |> y(i, w, h, y) |> y(i + 1, w, h, y) |> y(i - 1, w, h, y)
    end
  end
  defp xy(_n, a, _b, _c, _d), do: a

  defp y(l, i, w, h, y) do
    cond do
      h == 1 -> l
      y == 0 -> up(l, i + w)
      y == (h - 1) -> up(l, i - w)
      true -> up(l, i + w) |> up(i - w)
    end
  end

  defp up(list, index), do: if index < 0, do: list, else: List.update_at(list, index, &add1/1)

  defp add1("*"), do: "*"
  defp add1(i) when is_integer(i), do: i + 1
  defp add1(_), do: 1

  defp get_width([h | _]), do: String.length(h)
  defp dim1_2(i, width), do: {rem(i, width), i / width}
  defp list1_2(list, width), do: Enum.chunk_every(list, width)
  defp list2_1(list), do: { list |> Enum.reduce("", &(&2 <> &1)) |> String.graphemes, get_width(list)}
end
