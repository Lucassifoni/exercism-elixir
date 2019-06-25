defmodule wy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) when is_binary(question), do: answer(String.split(question, " "), {nil, nil, nil, nil})

  def answer(["plus" | ws], {a, op, nil, r}), do: answer(ws, {a, :plus, nil, r})
  def answer(["multiplied" | ws], {a, op, nil, r}), do: answer(ws, {a, :mul, nil, r})
  def answer(["minus" | ws], {a, op, nil, r}), do: answer(ws, {a, :minus, nil, r})
  def answer(["divided" | ws], {a, op, nil, r}), do: answer(ws, {a, :div, nil, r})
  def answer([w | ws], {nil, op, b, r }) do
    case Integer.parse(w, 10) do
      :error -> answer(ws, {nil, op, b, r})
      {num, _} -> answer(ws, {num, op, b, r})
    end
  end
  def answer([w | ws], {a, op, nil, r}) do
    case Integer.parse(w, 10) do
      :error -> answer(ws, {a, op, nil, r})
      {num, _} -> answer(ws, {apply_op(a, op, num), nil, nil, apply_op(a, op, num)})
    end
  end
  def answer([], {_, _, _, nil}), do: raise ArgumentError
  def answer([], {_, _, _, a}), do: a

  def apply_op(a, :plus, b), do: a + b
  def apply_op(a, :minus, b), do: a - b
  def apply_op(a, :mul, b), do: a * b
  def apply_op(a, :div, b), do: Integer.floor_div(a, b)
end
