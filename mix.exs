defmodule UniMux.Mixfile do
  use Mix.Project

  def project do
    [app: :unimux,
     version: "0.2.0",
     elixir: "~> 1.0",
     test_coverage: [tool: Coverex.Task, coveralls: true],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(Mix.env)]
  end

  def application do
    [applications: [:exometer_core, :logger, :elixir, :metricman, :hello, :runtime_tools, :exrun | (if Mix.env == :release do [:lager_journald_backend] else [] end)],
     mod: {UniMux, []}]
  end

  @doc_deps [:earmark, :ex_doc, :meck, :mock]
  defp deps(:release) do
    Code.eval_file("mix.lock")
    |> elem(0)
    |> Enum.filter_map(&(not (&1 in @doc_deps)), fn({key, _}) -> {key, path: "deps/" <> "#{key}", override: true} end)
  end

  defp deps(_) do
    [{:lager, "~> 2.1.1", override: true},
     {:hello, github: "travelping/hello", branch: "master"},
     {:metricman, github: "xerions/metricman", branch: "master"},
     {:exlager, github: "xerions/exlager"},
     {:exrun, github: "liveforeverx/exrun"},
     {:exrm, github: "thz/exrm", branch: "configurability", override: true},
     #{:coverex, "~> 1.4.1", only: :test},
     {:meck, "~> 0.8.2", override: true},
     {:mock, github: "jjh42/mock", override: true},
     {:exometer_core, github: "Feuerlabs/exometer_core", override: true},
		 {:edown, github: "uwiger/edown", override: true}]
  end
end
