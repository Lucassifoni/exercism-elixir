defmodule Isogram do
  import MapSet, only: [member?: 2, put: 2]
  def isogram?(sentence) do
    iso?(sentence, MapSet.new())
  end

  def iso?(" " <> r, c), do: iso?(r, c)
  def iso?("-" <> r, c), do: iso?(r, c)
  def iso?("", _), do: true
  def iso?(<<s::bytes-size(1)>> <> r, c), do: if member?(c, s), do: false, else: iso?(r, put(c, s))
end
