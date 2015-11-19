defmodule UniMuxTest do
  use ExUnit.Case

  import Mock

  require Record
  Record.defrecordp(:context, Record.extract(:context, from_lib: "hello/include/hello.hrl"))

  test "handle request - not found" do
    state = []
    assert {:stop, :not_found, {:ok, :not_found}, state} == UniMux.handle_request(:context, "a.b.c", [], state)
  end

  test_with_mock "handle request - ok", :hello_client, [call: fn(name, _) -> {:ok, name} end] do
    state = []
    Application.put_env(:unimux, :routes, [{"a", 'http://127.0.0.1:8080'}])
    assert UniMux.handle_request(:context, "a.b.c", [], state) == {:stop, :normal, {:ok, :unimux_a}, state}
    Application.put_env(:unimux, :routes, [{"a", 'http://127.0.0.1:8080'}, {"a.b", "http://127.0.0.1:8081"}])
    assert UniMux.handle_request(:context, "a.b.c", [], state) == {:stop, :normal, {:ok, :"unimux_a.b"}, state}
    Application.put_env(:unimux, :routes, [])
  end

  test "router" do
    id = 1
    assert {:ok, UniMux.name(), id} == UniMux.Router.route(context(session_id: id), :req, :uri)
  end
end
