defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    %Clock{} |> add(hour * 60 + minute)
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    total_mins = add_minute + minute + (hour * 60)
    hours = Integer.floor_div(total_mins, 60)
    rem_mins = total_mins - (hours * 60)
    %Clock{ hour: Integer.mod(hours, 24), minute: rem_mins }
  end
end

defimpl String.Chars, for: Clock do
  def to_string(clock) do
    "#{String.pad_leading(Integer.to_string(clock.hour), 2, "0")}:#{String.pad_leading(Integer.to_string(clock.minute), 2, "0")}"
  end
end