defmodule Weirding do
  @moduledoc """
  Weirding offers the best in class solution for generating tons of absurd text for your
  elixir project.

  ```
  Weirding.words()
  => "Holograms twisted her eyes. An uncomfortable stirring sounded genuinely happy. Case put aside to the lift of the blasphemy pouring her call it. Yueh stiffened, whirled away \"I didn’t remember it safe distance. And to a watch these garments\" the man shrugged."
  ```
  """

  @doc """
  Returns a sentence with the specified number of words.
  """
  def words(n \\ 45)
  def words(n) when n <= 0, do: ""
  def words(n) do
    Weirding.Chain.generate(n)
  end
end
