defmodule BeerSong do
  def plural(num, s) when num > 1, do: s <> "s"
  def plural(_, s), do: s

  def verse(0), do: "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  def verse(number), do: "#{number} #{plural(number, "bottle")} of beer on the wall, #{number} #{plural(number, "bottle")} of beer.\n"  <> second_sentence(number)

  def second_sentence(1), do: "Take it down and pass it around, no more bottles of beer on the wall.\n"
  def second_sentence(number), do: "Take one down and pass it around, #{number - 1} #{plural(number - 1, "bottle")} of beer on the wall.\n"

  def lyrics(), do: lyrics(99..0)
  def lyrics(range) do
    range |> Enum.reverse |> Enum.map(&verse/1) |> Enum.reduce(&(&1 <> "\n" <> &2))
  end
end
