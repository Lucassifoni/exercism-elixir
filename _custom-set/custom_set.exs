defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}
  # Keeping track of the size helps emptiness checks.
  defstruct map: %{}, size: 0

  import Map, only: [{:has_key?, 2}, {:keys, 1}, {:put, 3}]

  # Brevity helpers
  defp has?(%{ map: map }, el), do: has_key?(map, el)
  defp k(%{ map: map }), do: keys(map)
  defp put!(%{ map: map }, key, val), do: put(map, key, val)

  def new(enumerable), do: build(enumerable, %CustomSet{})
  def build([], set), do: set
  def build([x|xs], set), do: build(xs, add(set, x))
  def add(set, el), do: (if has?(set, el), do: set, else: %{ map: put!(set, el, 1), size: set.size + 1})

  def equal?(a, b), do: k(a) == k(b)
  def contains?(set, element), do: has?(set, element)
  def empty?(set), do: set.size == 0
  def subset?(a, b), do: k(a) |> Enum.map(fn key -> has?(b, key) end) |> Enum.reduce(true, fn v, o -> o && v end)
  def disjoint?(a, b), do: k(intersection(a, b)) |> length == 0

  def intersection(a, b), do: k(a) ++ k(b) |> Enum.reduce([], fn k, acc -> (if has?(a, k) && has?(b, k), do: [k | acc], else: acc) end) |> new
  def difference(a, b), do: k(a) -- k(b) |> new
  def union(a, b), do: k(a) ++ k(b) |> new
end
