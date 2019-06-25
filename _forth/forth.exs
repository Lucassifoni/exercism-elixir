defmodule Forth do
  @doc "Creates a fresh stack and environment"
  def new() do
    { [], %{
      "DUP" => &dup_op/1,
      "DROP" => &drop_op/1,
      "SWAP" => &swap_op/1,
      "OVER" => &over_op/1,
      "+" => fn a -> binary_op(a, &(&1 + &2)) end,
      "-" => fn a -> binary_op(a, &(&1 - &2)) end,
      "*" => fn a -> binary_op(a, &(&1 * &2)) end,
      "/" => &division_op/1
      }
    }
  end

  @doc "Format the current stack as a string."
  def format_stack({s, _}), do: s |> Enum.reverse |> Enum.join(" ")

  @doc "Evaluate an input string, updating the evaluator state."
  def eval({s, env}, str) when is_binary(str), do: e({s, env}, lex(str))

  defp push(stack, op), do: [op | stack]
  defp pop([s | tack]), do: {s, tack}

  defp string_or_int(el) do
    case Integer.parse(el) do
      :error -> el
      {a, _} -> a
    end
  end

  defp lex(s), do: s |> String.upcase |> String.split(~r/[\x01\s \x00]/u) |> Enum.map(&string_or_int/1)

  def e({s, env}, [":" | [kw | rest]]), do: define({s, env}, rest, kw, [])
  def e({s, env}, [op | rest]), do: apply_op({s, env}, op) |> e(rest)
  def e({s, env}, []), do: {s, env}

  defp define(_, _, kw, _) when is_integer(kw), do: raise Forth.InvalidWord, word: kw
  defp define({s, env}, [";" | rest], kw, ops), do: {s, Map.put(env, kw, &(e({&1, env}, ops) |> elem(0)))} |> e(rest)
  defp define({s, env}, [op | rest], kw, ops), do: define({s, env}, rest, kw, [op | ops])

  defp apply_op({s, env}, num) when is_integer(num), do: {push(s, num), env}
  defp apply_op({s, env}, op) when is_binary(op) do
    case Map.get(env, op) do
       nil -> raise Forth.UnknownWord, word: op
       fun -> { fun.(s), env}
    end
  end

  defp binary_op(stack, binary_fun) do
    {a, s} = pop(stack)
    {b, s} = pop(s)
    push(s, binary_fun.(b, a))
  end

  defp dup_op([]), do: raise Forth.StackUnderflow
  defp dup_op(stack), do: stack |> push(pop(stack) |> elem(0))

  defp drop_op([]), do: raise Forth.StackUnderflow
  defp drop_op(stack), do: pop(stack) |> elem(1)

  defp swap_op([]), do: raise Forth.StackUnderflow
  defp swap_op([_ | []]), do: raise Forth.StackUnderflow
  defp swap_op([s | [t | ack]]), do: [t | [s | ack]]

  defp over_op([]), do: raise Forth.StackUnderflow
  defp over_op([_ | []]), do: raise Forth.StackUnderflow
  defp over_op(stack) do
    {t, stack} = pop(stack)
    {o, stack} = pop(stack)
    stack |> push(o) |> push(t) |> push(o)
  end

  defp division_op([0 | _]), do: raise Forth.DivisionByZero
  defp division_op(stack), do: binary_op(stack, &Integer.floor_div/2)

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
