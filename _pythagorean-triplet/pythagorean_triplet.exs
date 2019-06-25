defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum([a, b, c]), do: a + b + c

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product([a, b, c]), do: a * b * c

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: a*a + b*b === c*c

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(nil, max), do: generate(1, max)
  def generate(min, max) do
    (for a <- min..max, b <- min..max, c <- min..max, pythagorean?([a, b, c]), do: [a, b, c])
      |> dedupe_by(&product/1)
      |> Enum.sort(&(product(&1) <= product(&2)))
  end

  def dedupe_by(list, func) do
    list
      |> Enum.reduce(%{ items: [], seen: %{} }, fn item, acc -> if Map.get(acc.seen, func.(item)), do: acc, else: %{ items: [item | acc.items], seen: Map.put(acc.seen, func.(item), true)} end)
      |> Map.get(:items)
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    generate(min, max) |> Enum.filter(fn triple -> Enum.sum(triple) === sum end)
  end
end
