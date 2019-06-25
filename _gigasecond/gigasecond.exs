defmodule Gigasecond do
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, n} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    NaiveDateTime.add(n, 1_000_000_000, :second) |> NaiveDateTime.to_erl
  end
end
