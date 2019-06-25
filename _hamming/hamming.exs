defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    if length(strand1) != length(strand2) do
      {:error, "Lists must be the same length"}
    else
      h(strand1, strand2)
    end
  end

  def h(s1, s2), do: List.zip([s1, s2]) |> Enum.reduce({:ok, 0}, fn {a, b}, {:ok, c} -> {:ok, c + (if a == b, do: 0, else: 1)} end)
end
