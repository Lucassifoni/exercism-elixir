defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string), do: string
                              |> String.graphemes
                              |> Enum.reverse
                              |> Enum.with_index
                              |> Enum.reduce(0, &accumulate_bin/2)
                              |> extract

  def extract(:error), do: 0
  def extract(n), do: n

  def accumulate_bin(_, :error), do: :error
  def accumulate_bin({"0", _}, r), do: r
  def accumulate_bin({"1", n}, r), do: r + (:math.pow(2, n) |> round)
  def accumulate_bin(_, _), do: :error
end
