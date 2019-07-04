defmodule ProteinTranslation do
  import Map, only: [get: 2, put: 3]
  import Enum, only: [reduce: 3, reverse: 1]

  @codonMap %{
              "Methionine" => ~w(AUG),
              "Phenylalanine" => ~w(UUU UUC),
              "Leucine" => ~w(UUA UUG),
              "Serine" => ~w(UCU UCC UCA UCG),
              "Tyrosine" => ~w(UAU UAC),
              "Cysteine" => ~w(UGU UGC),
              "Tryptophan" => ~w(UGG),
              "STOP" => ~w(UAA UAG UGA),
            }
            |> reduce(%{}, fn {k, v}, o ->
                reduce(v, o, fn a, z ->
                  put(z, a, k) end) end)

  def of_rna(rna) do
    case of_rna2(rna, []) do
      {:error, a} ->
        {:error, a}
      n ->
        {
          :ok,
          n
          |> reverse
        }
    end
  end

  def of_rna2(<<start::bytes-size(3)>> <> rest, l) do
    case of_codon(start) do
      {:ok, "STOP"} -> l
      {:ok, d} -> of_rna2(rest, [d | l])
      {:error, e} -> {:error, "invalid RNA"}
    end
  end
  def of_rna2("", l), do: l
  def of_rna2(a, l), do: {:error, "invalid RNA"}

  def of_codon(codon) do
    case get(@codonMap, codon) do
      nil -> {:error, "invalid codon"}
      a -> {:ok, a}
    end
  end
end
