defmodule WeirdingTest do
  use ExUnit.Case
  doctest Weirding

  test "starts with a capital" do
    first_word =
      Weirding.words(2)
      |> String.split(" ")
      |> Enum.at(0)

    assert first_word == String.capitalize(first_word)
  end

  test "generates text" do
    assert word_count(Weirding.words()) == 45
    assert word_count(Weirding.words(10)) == 10
    assert word_count(Weirding.words(5)) == 5
    assert word_count(Weirding.words(0)) == 0
    assert word_count(Weirding.words(-1)) == 0
  end

  def word_count(text) do
    text
    |> String.split(" ")
    |> Enum.reject(& &1 == "")
    |> Enum.count
  end
end
