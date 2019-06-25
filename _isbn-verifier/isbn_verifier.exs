defmodule ISBNVerifier do
  def isbn?(isbn) when is_binary(isbn) do
    cond  do
      String.length(isbn) > 13 -> false
      true -> Regex.replace(~r/[^0-9X]/, isbn, "")
              |> String.graphemes
              |> isbn?
    end
  end


  def isbn?([a, b, c, d, e, f, g, h, i, "X"] = list),
      do: convert(list)
          |> checksum
  def isbn?([a, b, c, d, e, f, g, h, i, j] = list),
      do: convert(list)
          |> checksum
  def isbn?(_), do: false

  def convert(list),
      do: list
          |> Enum.map(
               fn c -> case Integer.parse(c) do
                         :error -> if c == "X", do: 10, else: 0
                         {num, _} -> num
                       end
               end
             )

  def checksum([_, _, _, _, _, _, _, _, _, _] = list),
      do: Enum.zip(10..1, list)
          |> Enum.reduce(0, fn {a, b}, acc -> acc + a * b end)
          |> rem(11) == 0
  def checksum(_), do: false
end
