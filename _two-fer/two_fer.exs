defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(), do: two_fer("you")
  def two_fer(you) when is_binary(you), do: "One for #{you}, one for me"
  def two_fer(_), do: raise FunctionClauseError
end
