defmodule CommonGraphqlClient.MixProject do
  use Mix.Project

  @version "0.6.2"
  @url "https://github.com/annkissam/common_graphql_client"
  @maintainers [
    "Josh Adams",
    "Eric Sullivan",
    "Adi Iyengar"
  ]

  def project do
    [
      aliases: aliases(),
      app: :common_graphql_client,
      deps: deps(),
      description: "Elixir GraphQL Client with HTTP and WebSocket Support",
      docs: docs(),
      elixir: "~> 1.6",
      preferred_cli_env: [
        analysis: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      homepage_url: @url,
      package: package(),
      source_url: @url,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:absinthe_websocket, "~> 0.2.2", optional: true},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false},
      {:ecto, "~> 2.2 or ~> 3.0", optional: true},
      {:ecto_sql, "~> 3.0", optional: true},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: [:test]},
      {:httpoison, "~> 1.1", optional: true}
    ]
  end

  def docs do
    [
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}"
    ]
  end

  defp package do
    [
      name: :common_graphql_client,
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{github: @url},
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*", "CHANGELOG.md"]
    ]
  end

  defp aliases do
    [publish: ["hex.publish", &git_tag/1]]
  end

  defp git_tag(_args) do
    System.cmd("git", ["tag", "v" <> Mix.Project.config()[:version]])
    System.cmd("git", ["push", "--tags"])
  end
end
