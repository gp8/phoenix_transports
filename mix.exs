defmodule PhoenixTransports.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_transports,
      version: "0.0.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixTransports.Application, []},
      extra_applications: [:logger, :runtime_tools, :ranch]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:ranch, "~> 1.3"},
      {:jason, "~> 1.0"},
      ##{:poison, "~> 3.0"},
      {:phoenix, "~> 1.4.0-rc"},
    ]
  end
end
