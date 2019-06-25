defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    {_, r} = {number, ""}
          |> fac(3, "Pling")
          |> fac(5, "Plang")
          |> fac(7, "Plong")
    case r do
      "" -> Integer.to_string(number)
      a -> a
    end
  end

  def fac({number, out}, factor, add) when rem(number, factor) == 0, do: {number, out <> add}
  def fac({number, out}, _, _), do: {number, out}
end
