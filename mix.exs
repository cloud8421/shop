defmodule Shop.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer_warnings: [:unmatched_returns, :error_handling, :race_conditions, :unknown],
      dialyzer_ignored_warnings: [
        {:warn_contract_supertype, :_, {:extra_range, [:_, :__protocol__, 1, :_, :_]}}
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [{:dialyzex, "~> 1.1", only: :dev}]
  end
end
