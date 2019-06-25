defmodule ScaleGenerator do

  @basescale ~w(C C# D D# E F F# G G# A A# B C)
  @flatscale ~w(A Bb B C Db D Eb E F Gb G Ab)
  @flat_candidates ~w(F Bb Eb Ab Db Gb d g c f bb eb)

  defp halftones_or_id(a), do: Map.get(%{ "m" => 1, "M" => 2, "A" => 3 }, a, a)
  defp u(s), do: String.capitalize(s)

  def step(scale, tonic, step), do: Enum.at(scale, rem(Enum.find_index(scale, fn note -> note === u(tonic) end) + halftones_or_id(step), 12))

  def step_reduce(scale, tonic, []), do: tonic
  def step_reduce(scale, tonic, [s | steps]), do: step_reduce(scale, step(scale, tonic, s), steps)

  defp chroma(scale, tonic), do: Enum.map(0..12, fn step -> step(scale, u(tonic), step) end)

  def chromatic_scale(tonic \\ "C"), do: chroma(@basescale, tonic)
  def flat_chromatic_scale(tonic \\ "C"), do: chroma(@flatscale, tonic)
  def find_chromatic_scale(tonic), do: (if Enum.member?(@flat_candidates, tonic) do flat_chromatic_scale(tonic) else chromatic_scale(tonic) end)

  def scale(tonic, pattern) do
    scale = (if Enum.member?(@flat_candidates, tonic) do @flatscale else @basescale end)
    { _, out } = String.graphemes(pattern) |> Enum.reduce({[], []}, fn i, {p, acc} -> {[i | p], [step_reduce(scale, u(tonic), p) | acc ]} end)
    [u(tonic) | out] |> Enum.reverse
  end
end
