defmodule RotationalCipher do
  def rotate(text, val), do: text |> String.to_charlist |> Enum.map(fn c -> shift(c, val) end) |> List.to_string

  def shift(char, val) do
    case char do
      char when char in ?a..?z -> shift(?a, char, val)
      char when char in ?A..?Z -> shift(?A, char, val)
      char -> char
    end
  end

  @alpha 26
  def shift(from, char, val), do: from + rem(char - from + rem(val, @alpha), @alpha)
end
