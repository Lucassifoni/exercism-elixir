defmodule Allergies do
  use Bitwise

  def list(flags), do: flags |> map_flags

  def map_flags(flags) do
    [
      "eggs",
      "peanuts",
      "shellfish",
      "strawberries",
      "tomatoes",
      "chocolate",
      "pollen",
      "cats"
    ] |> Enum.with_index
      |> Enum.reduce(MapSet.new(), fn {a, i}, set -> flag_if(set, flags, a, (:math.pow(2, i)|> round)) end)
  end

  def flag_if(xs, input, x, mask), do: if (input &&& mask) === mask, do: MapSet.put(xs, x), else: xs
  def allergic_to?(flags, item), do: MapSet.subset?(Enum.into([item], MapSet.new()), list(flags))
end