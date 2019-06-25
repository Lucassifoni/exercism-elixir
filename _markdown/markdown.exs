defmodule Markdown do

  defp lines(str), do: String.split(str, "\n")
  defp words(str), do: String.split(str)
  defp unwords(words), do: Enum.join(words, " ")

  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
      |> lines
      |> Enum.map(&process/1)
      |> Enum.join
      |> fix_lists
  end

  defp process("#" <> rest = s), do: header_level(s) |> header(s)
  defp process("*" <> _ = s), do: list_level(s)
  defp process(s), do: ~s|<p>#{join_words_with_tags(s)}</p>|

  defp header_level(string), do: words(string) |> List.first |> String.length
  defp list_level(string), do: "<li>#{join_words_with_tags(String.trim_leading(string, "* "))}</li>"

  defp header(level, text), do: ~s|<h#{level}>#{String.slice(text, level + 1, (String.length(text) - level))}</h#{level}>|
  defp join_words_with_tags(string), do: string |> words |> Enum.map(&md/1) |> unwords

  defp md(word), do: word |> replace_prefix_md |> replace_suffix_md

  defp replace_prefix_md("__" <> text), do: "<strong>" <> text
  defp replace_prefix_md("_" <> text), do: "<em>" <> text
  defp replace_prefix_md(text), do: text

  defp replace_suffix_md(w) do
    cond do
      Regex.match?(~r/#{"__"}{1}$/, w) -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      Regex.match?(~r/[^#{"_"}{1}]/, w) -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp fix_lists(text) do
    text
      |> String.replace("<li>", "<ul><li>", global: false)
      |> String.replace_suffix("</li>", "</li></ul>")
  end
end
