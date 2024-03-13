defmodule TinyProxyTest do
  use ExUnit.Case

  test "Tiny Proxy Req Package" do
    assert ProxyTest.TinyProxy.Req.bad_request() == :bad
    assert ProxyTest.TinyProxy.Req.good_request() == :good
  end

  test "Tiny Proxy Finch Package" do
    assert ProxyTest.TinyProxy.Finch.bad_request() == :bad
    assert ProxyTest.TinyProxy.Finch.good_request() == :good
  end

  test "Tiny Proxy HTTPoison Package" do
    assert ProxyTest.TinyProxy.HTTPoison.bad_request() == :bad
    assert ProxyTest.TinyProxy.HTTPoison.good_request() == :good
  end

  test "Tiny Proxy Mint Package" do
    assert ProxyTest.TinyProxy.Mint.bad_request() == :bad
    assert ProxyTest.TinyProxy.Mint.good_request() == :good
  end
end
