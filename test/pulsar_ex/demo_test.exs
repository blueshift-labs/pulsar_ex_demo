defmodule PulsarEx.DemoTest do
  use ExUnit.Case
  doctest PulsarEx.Demo

  test "greets the world" do
    assert PulsarEx.Demo.hello() == :world
  end
end
