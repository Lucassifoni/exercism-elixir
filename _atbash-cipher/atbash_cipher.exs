defmodule Atbash do

  # According to wikipedia, coding and decoding is the same function when you remap
  # the alphabet from ?a..?z to 0..26 :-) https://en.wikipedia.org/wiki/Atbash#Relationship_to_the_affine_cipher
  def decode(cipher), do: cipher |> code_str |> to_string
  def encode(plaintext), do: plaintext |> code_str |> Enum.chunk_every(5) |> Enum.join(" ")

  def code_str(s), do: String.downcase(s) |> to_charlist |> Enum.reduce([], &cond_code/2) |> Enum.reverse
  def code(c), do: (?z - (c - ?a))
  def cond_code(c, out) do
    cond do
      c in ?a..?z ->[code(c) | out]
      c in ?0..?9 -> [c | out]
      true -> out
    end
  end
end
