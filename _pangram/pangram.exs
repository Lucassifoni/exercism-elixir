defmodule Pangram do
  @alpha ?a..?z |> Enum.into(MapSet.new())

  def pangram?(sentence) do
    set = String.downcase(sentence)
      |> String.to_charlist
      |> Enum.reduce(MapSet.new(), fn x, xs -> MapSet.put(xs, x) end)

    MapSet.subset?(@alpha, set)
  end
end
