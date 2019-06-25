defmodule NucleotideCount do
  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide), do: Enum.reduce(strand, 0, fn nuc, count -> count + (if nuc === nucleotide do 1 else 0 end) end)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    h(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  end

  defp h([], acc), do: acc
  defp h([nuc | strand], acc), do: h(strand, Map.put(acc, nuc, Map.get(acc, nuc, 0) + 1))
end
