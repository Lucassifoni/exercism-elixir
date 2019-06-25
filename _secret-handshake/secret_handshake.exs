defmodule SecretHandshake do
  use Bitwise

  def commands(code) do
    []
      |> appendif(code, 0x01, "wink")
      |> appendif(code, 0x02, "double blink")
      |> appendif(code, 0x04, "close your eyes")
      |> appendif(code, 0x08, "jump")
      |> reverseif(code, 0x10)
  end

  def appendif(list, code, pattern, output), do: if (pattern &&& code) === pattern, do: list ++ [output], else: list
  def reverseif(list, code, pattern), do: if (pattern &&& code) === pattern, do: list |> Enum.reverse, else: list
end
