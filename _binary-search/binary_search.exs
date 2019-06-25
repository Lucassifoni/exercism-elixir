defmodule BinarySearch do
  def search(nums, key), do: search(nums, key, 0, tuple_size(nums), tuple_size(nums))
  def search(_, _, _, _, 0), do: :not_found
  def search(_, _, left, right, size) when right < left, do: :not_found
  def search(nums, key, left, right, size) do
    i = left + Integer.floor_div(right - left, 2)
    if i >= size do
      :not_found
    else
      e = elem(nums, i)
      cond do
        e == key -> {:ok, i}
        e < key -> search(nums, key, i + 1, right, size)
        e > key -> search(nums, key, left, i - 1, size)
      end
    end
  end
end
