defmodule BracketPush do
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str), do: str |> String.to_charlist |> check([])

  defp push(char, stack), do: [char | stack]
  defp discard([_ | stack]), do: stack

  def check([], []), do: true
  def check([], _), do: false
  def check([c | cs], s) when c in [?(, ?[, ?{], do: check(cs, push(c, s))
  def check([?) | cs], [?( | _] = s), do: check(cs, discard(s))
  def check([?] | cs], [?[ | _] = s), do: check(cs, discard(s))
  def check([?} | cs], [?{ | _] = s), do: check(cs, discard(s))
  def check([c | _], _) when c in [?), ?], ?}], do: false
  def check([_ | cs], s), do: check(cs, s)
end
