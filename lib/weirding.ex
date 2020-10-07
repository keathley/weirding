defmodule Weirding do
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  @doc """
  Returns a sentence with the specified number of words.
  """
  def words(n \\ 45)
  def words(n) when n <= 0, do: ""
  def words(n) do
    Weirding.Chain.generate(n)
  end
end
