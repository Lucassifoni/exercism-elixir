defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  def append(a, b), do: a(reverse(a), b)
  def a([],    b), do: b
  def a([x | xs], b), do: a(xs, [x | b])

  def concat(ls), do: concat(reverse(ls), [])
  def concat([], a), do: a
  def concat([x|xs], a), do: concat(xs, append(x, a))

  def reverse(l), do: reverse(l, [])
  def reverse([], a), do: a
  def reverse([x | xs], a), do: reverse(xs, [x | a])

  def reduce([], acc, _), do: acc
  def reduce([x | xs], acc, f), do: reduce(xs, f.(x, acc), f)
  def count(l), do: reduce(l, 0, fn (_, a) -> a + 1 end)
  def map(l, f), do: reduce(l, [], fn(x, xs) -> [f.(x) | xs] end) |> reverse
  def filter(l, f), do: reduce(l, [], fn(x, xs) -> if f.(x) do [x | xs] else xs end end) |> reverse
end
