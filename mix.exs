defmodule PulsarEx.Demo.MixProject do
  use Mix.Project

  def project do
    [
      app: :pulsar_ex_demo,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PulsarEx.Demo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:pulsar_ex, "~> 0.14.1"}
    ]
  end
end
