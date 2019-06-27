defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list), do: f(list)
  def f([]), do: []
  def f([x | xs]), do: f(x) ++ f(xs)
  def f(nil), do: []
  def f(x), do: [x]
end
