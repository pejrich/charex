defmodule Charex.MixProject do
  use Mix.Project

  @version "0.4.0"
  @source_url "https://github.com/pejrich/charex"

  def project do
    [
      app: :charex,
      description:
        "Elixir NIF wrapper of the Rust Charabia string tokenization/segmentation library",
      package: [
        name: "charex",
        licenses: ["MIT"],
        links: %{"GitHub" => @source_url},
        source_url: @source_url,
        files: ~w(lib .formatter.exs mix.exs README* LICENSE*
                 CHANGELOG*)
      ],
      docs: [
        main: "charex",
        extras: ["README.md"]
      ],
      version: @version,
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:rustler, ">= 0.0.0", optional: true},
      {:rustler_precompiled, "~> 0.7.0"},
      {:benchee, "~> 1.1", only: [:dev, :test]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
