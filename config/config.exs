# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config


config :unimux,
  routes: [{"APIPrefix", 'http://127.0.0.1:8080', 10000}],
  listen: 'zmq-tcp://127.0.0.1:20000',
  default_timeout: 10000

try do
    import_config "../deps/metricman/config/config.exs"
rescue
    _ in _ ->
          :skip
end

config :setup, :home, '/tmp'
