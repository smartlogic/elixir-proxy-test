defmodule CaddyProxyTest do
  use ExUnit.Case

  test "Caddy Proxy Req Package" do
    assert ProxyTest.CaddyProxy.Req.bad_request() == :bad
    assert ProxyTest.CaddyProxy.Req.good_request() == :good
  end

  test "Caddy Proxy Finch Package" do
    assert ProxyTest.CaddyProxy.Finch.bad_request() == :bad
    assert ProxyTest.CaddyProxy.Finch.good_request() == :good
  end

  test "Caddy Proxy HTTPoison Package" do
    assert ProxyTest.CaddyProxy.HTTPoison.bad_request() == :bad
    assert ProxyTest.CaddyProxy.HTTPoison.good_request() == :good
  end

  test "Caddy Proxy Mint Package" do
    assert ProxyTest.CaddyProxy.Mint.bad_request() == :bad
    assert ProxyTest.CaddyProxy.Mint.good_request() == :good
  end
end
