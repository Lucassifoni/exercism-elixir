defmodule Sublist do
  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, a), do: :equal
  def compare(a, b) do
    cond do
      contains?(a, b) -> :sublist
      contains?(b, a) -> :superlist
      1 -> :unequal
    end
  end

  def contains?(a, b), do: contains?(a, b, a) # Let's keep the original list around
  def contains?(a, [_b | a], _), do: true # Tail matches list, exit
  def contains?([a | b], [a | c], o), do: contains?(b, c, o) # Heads match, check tails
  def contains?([], _, _), do: true # Cf. compare/2
  def contains?(_, [_ | d], o), do: contains?(o, d) # Let's restart with the second list's tail
  def contains?(_, [], _), do: false # Cf. compare/2
end
