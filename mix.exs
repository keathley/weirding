defmodule Weirding.MixProject do
  use Mix.Project

  @source_url "https://github.com/keathley/weirding"
  @version "0.2.2"

  def project do
    [
      app: :weirding,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      description: description(),
      package: package(),
      name: "Weirding",
      source_url: @source_url,
      docs: docs(),
    ]
  end

  def application do
    [
      mod: {Weirding.Application, []}
    ]
  end

  defp deps do
    [
      {:benchee, "~> 1.0", only: [:dev]},
      {:ex_doc, "~> 0.19", only: [:dev, :test]},
    ]
  end

  def description do
    """
    Weirding is the best way to generate complete gibberish.
    """
  end

  def package do
    [
      name: "weirding",
      files: ["lib", "mix.exs", "LICENSE.md", "README.md", "priv"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      source_url: @source_url,
      main: "Weirding",
    ]
  end
end
