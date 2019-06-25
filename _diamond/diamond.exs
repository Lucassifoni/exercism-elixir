defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    (?A..letter |> Enum.map(&(build_line(&1, letter))) |> mirror |> Enum.join("\n")) <> "\n"
  end

  def build_line(?A, peak), do: s(peak - ?A) <> "A" <> s(peak - ?A)
  def build_line(letter, peak), do: (s(peak - letter) <> t(letter) <> s(letter - ?A)) |> mirror

  def mirror(list) when is_list(list) do
    [_ | a] = Enum.reverse(list)
    list ++ a
  end

  def mirror(s) when is_binary(s) do
    String.graphemes(s) |> mirror |> Enum.join("")
  end

  def t(l), do: List.to_string([l])
  def s(a), do: String.duplicate(" ", a)
end
