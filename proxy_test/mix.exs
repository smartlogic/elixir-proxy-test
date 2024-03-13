defmodule ProxyTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :proxy_test,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ProxyTest.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.18.0"},
      {:req, "~> 0.4.13"},
      {:castore, "~> 1.0"},
      {:mint, "~> 1.0"},
      {:httpoison, "~> 2.0"}
    ]
  end
end
