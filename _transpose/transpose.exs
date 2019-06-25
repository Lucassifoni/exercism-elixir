defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  def at_or(str, i) do
    a = String.at(str, i)
    case a do
      nil -> " "
      b -> b
    end
  end

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    rows = input |> String.split("\n")
    size = rows |> Enum.reduce(0, fn row, s -> if String.length(row) > s, do: String.length(row), else: s end)
    Enum.reduce(0..size - 1, [], fn (i, list) -> [
       Enum.reduce(rows, "", fn (row, str) -> str <> at_or(row, i) end)
       | list] end)
        |> Enum.reverse
        |> Enum.join("\n")
        |> String.trim
  end
end
