defmodule Sieve do
  @moduledoc """
  Note : this is the sequential-addition version from Wikipedia
  Substracting lists this way is generally a bad idea
  """
  def primes_to(limit), do: 2..limit |> Enum.to_list |> primes([], limit)

  def primes([], out, _n), do: out |> Enum.reverse
  def primes([h | t] = to_see, primes, limit), do: primes(t -- add_until(h, limit), [h | primes], limit)

  def add_until(n, limit), do: add_until(n, n, limit, [])
  def add_until(n, a, limit, out) when a > limit, do: out
  def add_until(n, a, limit, out), do: add_until(n, a + n, limit, [a | out])
end
