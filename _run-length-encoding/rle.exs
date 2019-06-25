defmodule RunLengthEncoder do
  def encode(""), do: ""
  def encode(string), do: string |> String.graphemes() |> enc

  @doc """
  Encodes a list of chars to a RLE string
  """
  def enc([cur|rest]), do: enc(rest, 1, cur, "")
  def enc([], n, char, buf), do: flush(n, char, buf)
  def enc([cur|rest], n, cur, buf), do: enc(rest, n + 1, cur, buf)
  def enc([cur|rest], n, prev, buf), do: enc(rest, 1, cur, flush(n, prev, buf))

  @doc """
  Flushes a char and its n occurences to the buffer
  """
  defp flush(n, char, buf), do: (if n == 1, do: buf <> char, else: buf <> Integer.to_string(n) <> char)

  def decode(""), do: ""
  def decode(string), do: Regex.scan(~r/(\d*)([^\d])/, string) |> Enum.map(&decode_chunk/1) |> Enum.join("")

  @doc """
  Decodes a chunk from its RLE form
  """
  defp decode_chunk([_, "", a]), do: a
  defp decode_chunk([_, n, a]), do: String.duplicate(a, String.to_integer(n))
end
