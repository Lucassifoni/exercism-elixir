defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    l = texts
        |> Enum.join("")
        |> String.downcase
        |> String.replace(~r/[\d\W\s]/u, "")
    if (String.length(l) === 0) do
      %{}
    else
      l |> String.split("")
        |> Enum.chunk_every(ceil(String.length(l) / workers))
        |> Enum.map(fn a -> Task.async(fn -> frequency(a) end) end)
        |> Enum.map(&Task.await/1)
        |> merge_results
        |> filter_map
    end
  end

  def filter_map(map) do
    Enum.reduce(Map.keys(map), %{}, fn k, out -> if String.length(k) === 0, do: out, else: Map.put(out, k, Map.get(map, k)) end)
  end

  def frequency(chars), do: Enum.reduce(chars, %{}, fn char, map -> Map.put(map, char, Map.get(map, char, 0) + 1) end)
  def merge_results(freqs), do: Enum.reduce(freqs, %{}, fn map, acc -> Map.merge(map, acc, fn _, v, w -> v + w end) end)
end
