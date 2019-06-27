defmodule LinkedList do
  @opaque t :: tuple()
  defstruct data: nil, cons: nil

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: nil

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(l, elem), do: %LinkedList{data: elem, cons: l}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(nil), do: 0
  def length(l), do: LinkedList.length(l.cons) + 1

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(nil), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(l), do: if empty?(l), do: {:error, :empty_list}, else: {:ok, l.data}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(nil), do: {:error, :empty_list}
  def tail(l), do: {:ok, l.cons}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(nil), do: {:error, :empty_list}
  def pop(l), do: {:ok, l.data, l.cons}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(l), do: from_list(l, nil)
  def from_list([], carry),
      do: carry
          |> reverse
  def from_list([x | xs], carry), do: from_list(xs, %LinkedList{data: x, cons: carry})

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: to_list(list, [])
  def to_list(nil, carry),
      do: carry
          |> Enum.reverse
  def to_list(list, carry), do: to_list(list.cons, [list.data | carry])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: reverse(list, nil)
  def reverse(nil, carry), do: carry
  def reverse(list, carry), do: reverse(list.cons, %LinkedList{data: list.data, cons: carry})
end
