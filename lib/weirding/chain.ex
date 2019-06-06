defmodule Weirding.Chain do
  def build(corpus) do
    corpus
    |> String.split()
    |> create_wordlist(%{})
  end

  defp create_wordlist([], wordlist), do: wordlist
  defp create_wordlist([_], wordlist), do: wordlist
  defp create_wordlist([word, next_word | rest], wordlist) do
    new_wordlist = update_in(wordlist, [word], & [next_word | &1 || []])
    create_wordlist([next_word | rest], new_wordlist)
  end

  def to_stream(wordlist) do
    Stream.resource(
      fn -> wordlist end,
      fn
        {wordlist, word} ->
          next = next_word(wordlist, word)
          {[next], {wordlist, next}}

        wordlist ->
          {word, _} =
            wordlist
            |> Enum.shuffle
            |> Enum.find(fn {word, _} -> word == String.capitalize(word) end)

          {[word], {wordlist, word}}
      end,
      fn _ -> nil end
    )
  end

  defp next_word(wordlist, word) do
    case wordlist[word] do
      nil ->
        ""

      followers ->
        Enum.random(followers)
    end
  end
end
