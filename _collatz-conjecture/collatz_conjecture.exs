defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(number :: pos_integer) :: pos_integer
  def calc(input) when not is_integer(input) or input <= 0, do: raise FunctionClauseError
  def calc(input), do: calc(input, 0)
  def calc(1, steps), do: steps
  def calc(n, steps), do: if Integer.mod(n, 2) === 0, do: calc(round(n / 2), steps + 1), else: calc(n * 3 + 1, steps + 1)
end
