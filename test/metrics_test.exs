defmodule MetricsTest do
  use ExUnit.Case

  import Mock

  test_with_mock "handle request - ok", :hello_client, [call: fn(name, _) -> {:ok, name} end] do
    :exometer.reset([:unimux, String.to_atom("hello_client_a"), :resolved])
    Application.put_env(:unimux, :routes, [{"a", 'http://127.0.0.1:8080'}])
    UniMux.handle_request(:context, "a.b.c", [], [])
    assert {:ok, [{:value, 1}, {:ms_since_reset, _}]} = :exometer.get_value([:unimux, :hello_client_a, :resolved])
    Application.put_env(:unimux, :routes, [])
  end

  test "test for metrics" do
    :exometer.reset([:unimux, :not_resolved])
    assert {:stop, :not_found, {:ok, :not_found}, []} == UniMux.handle_request(:context, "a.b.c", [], [])
    assert {:stop, :not_found, {:ok, :not_found}, []} == UniMux.handle_request(:context, "a.b.c", [], [])
    assert {:ok, [{:value, 2}, {:ms_since_reset, _}]} = :exometer.get_value([:unimux, :not_resolved])
  end
end
