defmodule Acronym do
  def abbreviate([], _, acc), do: acc |> String.upcase
  def abbreviate([current | next], nil, acc), do: abbreviate(next, current, acc <> to_string([current]))
  def abbreviate([current | next], previous, acc) do
    case current do
      current when current in ?A..?Z and previous not in ?A..?Z -> abbreviate(next, current, acc <> to_string([current]))
      current when previous == ?\s -> abbreviate(next, current, acc <> to_string([current]))
      current -> abbreviate(next, current, acc)
    end
  end

  def abbreviate(string), do: abbreviate(String.to_charlist(string), nil, "")
end
