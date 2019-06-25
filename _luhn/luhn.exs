defmodule Luhn do
  import Enum, only: [sum: 1, reverse: 1, map_every: 3, map: 2, drop: 2, all?: 2]
  import String, only: [trim: 1, replace: 3, graphemes: 1, to_integer: 1]

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
      |> rail(&trim/1)
      |> rail(&remove_spaces/1)
      |> rail(&only_numbers?/1) # Note that rail isn't needed until this point but used for consistency
      |> rail(&more_than_one_digit?/1)
      |> rail(&to_numbers/1)
      |> rail(&double_every_second_from_the_right/1)
      |> rail(&sum/1)
      |> rail(&divisible_by_10?/1)
  end

  defp remove_spaces(a), do: replace(a, ~r/\s/, "")
  defp to_numbers(a), do: a |> graphemes |> map(&to_integer/1)
  defp double_every_second_from_the_right(a), do: [0 | reverse(a)] |> map_every(2, &double_and_process/1) |> drop(1) |> reverse
  defp double_and_process(a), do: (if a * 2 > 9 do a * 2 - 9 else a * 2 end)
  defp only_numbers?(a), do: (if graphemes(a) |> all?(&(Integer.parse(&1) != :error)) do a else false end)
  defp more_than_one_digit?(a), do: (if String.length(a) > 1 do a else false end)
  defp divisible_by_10?(a), do: rem(a, 10) == 0

  defp rail(false, _), do: false
  defp rail(val, fun), do: fun.(val)
end
