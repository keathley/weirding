defmodule Weirding do
  @moduledoc File.read!(Path.join([__DIR__, "../README.md"]))

  alias Weirding.Chain

  @external_resource "priv/dune.txt"
  @dune File.read!("priv/dune.txt")

  @external_resource "priv/neuromancer.txt"
  @neuromancer File.read!("priv/neuromancer.txt")

  @chain Chain.build(@dune <> "\n" <> @neuromancer)

  @doc """
  Returns a sentence with the specified number of words.
  """
  def words(n \\ 45)
  def words(n) when n <= 0, do: ""
  def words(n) do
    @chain
    |> Chain.to_stream
    |> Enum.take(n)
    |> Enum.join(" ")
  end
end
