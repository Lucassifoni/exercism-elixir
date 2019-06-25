defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.split(~r/[^\p{L}\d-]/u) # Split at non-letters, non-digits and non-normal-dashes
      |> Enum.filter(&(String.length(&1) > 0)) # Filter resulting voids
      |> Enum.reduce(%{}, &word_map/2)
  end

  defp word_map(word, map) do
    key = String.downcase(word)
    Map.put(map, key, Map.get(map, key, 0) + 1)
  end
end
