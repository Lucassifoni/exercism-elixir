defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input), do: input |> Map.to_list |> Enum.reduce(%{}, fn {k, vs}, m -> Enum.reduce(vs, m, fn v, a -> Map.put(a, String.downcase(v), k) end) end)
end
