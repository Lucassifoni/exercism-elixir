defmodule RNATranscription do
  @rnaMap %{
    71 => 67,
    67 => 71,
    84 => 65,
    65 => 85
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
      |> Enum.map(fn char ->  Map.get(@rnaMap, char) end)
      |> Enum.filter(&(&1))
  end
end
