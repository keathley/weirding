defmodule Mix.Tasks.Weirding.BuildChain do
  def run(_) do
    corpus = File.read!("priv/corpus.txt")
    chain = Weirding.Chain.build(corpus)
    bin = :erlang.term_to_binary(chain)
    File.write!("priv/chain.txt", bin)
  end
end
