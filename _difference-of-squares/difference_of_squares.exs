defmodule Squares do
  def sum_of_squares(number), do: 1..number |> Enum.map(&(:math.pow(&1, 2))) |> Enum.sum |> round
  def square_of_sum(number), do: 1..number |> Enum.sum |> :math.pow(2) |> round
  def difference(number), do: square_of_sum(number) - sum_of_squares(number)
end
