defmodule Weirding.Chain do
  @moduledoc false
  # This module provides a basic markov chain for generating text. It also defines
  # a GenServer. The GenServer is designed to load the pre-built chain when the
  # weirding application boots, convert the chain from binary back into a term,
  # and store it in persistent_term.
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Build is called by a mix task in order to build the latest corpus into a chain
  # which is then written into a file using term_to_binary.
  @doc false
  def build(corpus) do
    corpus
    |> cleanup
    |> create_wordlist(%{})
  end

  defp cleanup(str) do
    str
    |> String.split()
    |> Enum.map(& String.replace(&1, "\"", ""))
    |> Enum.map(& String.replace_leading(&1, "-", ""))
  end

  defp create_wordlist([], wordlist), do: wordlist
  defp create_wordlist([_], wordlist), do: wordlist
  defp create_wordlist([word, next_word | rest], wordlist) do
    new_wordlist = update_in(wordlist, [word], & [next_word | &1 || []])
    create_wordlist([next_word | rest], new_wordlist)
  end

  def generate(n) when n > 0 do
    chain = chain()
    {word, _followers} = Enum.random(chain)
    acc = [String.capitalize(word)]

    generate(chain, word, acc, n-1)
  end

  defp generate(_, _, acc, 0) do
    acc
    |> Enum.reverse
    |> Enum.join(" ")
  end
  defp generate(chain, word, acc, n) do
    case Enum.random(chain[word]) do
      nil ->
        # If there are no followers than we should just grab a new random word
        # and keep going.
        {next, _} = Enum.random(chain)
        generate(chain, next, [next | acc], n)

      next ->
        generate(chain, next, [next | acc], n-1)
    end
  end

  def init(_opts) do
    term = :erlang.binary_to_term(File.read!("priv/chain.txt"))
    :persistent_term.put({Weirding, :chain}, term)

    {:ok, %{}}
  end

  defp chain, do: :persistent_term.get({Weirding, :chain})
end
