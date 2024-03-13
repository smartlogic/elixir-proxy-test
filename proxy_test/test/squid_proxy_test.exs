defmodule SquidProxyTest do
  use ExUnit.Case

  test "Squid Proxy Req Package" do
    assert ProxyTest.SquidProxy.Req.bad_request() == :bad
    assert ProxyTest.SquidProxy.Req.good_request() == :good
  end

  test "Squid Proxy Finch Package" do
    assert ProxyTest.SquidProxy.Finch.bad_request() == :bad
    assert ProxyTest.SquidProxy.Finch.good_request() == :good
  end

  test "Squid Proxy HTTPoison Package" do
    assert ProxyTest.SquidProxy.HTTPoison.bad_request() == :bad
    assert ProxyTest.SquidProxy.HTTPoison.good_request() == :good
  end

  test "Squid Proxy Mint Package" do
    assert ProxyTest.SquidProxy.Mint.bad_request() == :bad
    assert ProxyTest.SquidProxy.Mint.good_request() == :good
  end
end
