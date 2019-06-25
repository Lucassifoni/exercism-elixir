defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    ref = ana_map(base)
    Enum.reduce(candidates, [], fn c, out -> if is_ana?(ref, ana_map(c)), do: [c | out], else: out end) |> Enum.reverse
  end

  def is_ana?(%{ "word" => w }, %{ "word" => w }), do: false
  def is_ana?(m1, m2) do
    k1 = Map.keys(m1)
    k2 = Map.keys(m2)
    if k1 != k2 do
      false
    else
      Enum.reduce(k1, true, fn key, flag -> (if flag == false || key == "word", do: flag, else: Map.get(m1, key) == Map.get(m2, key)) end)
    end
  end

  def ana_map(str) do
    s = String.downcase(str)
    s
      |> String.split("")
      |> Enum.reduce(%{"word" => s}, fn char, map -> Map.put(map, char, Map.get(map, char, 0) + 1) end)
  end
end
