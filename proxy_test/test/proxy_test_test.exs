defmodule ProxyTestTest do
  use ExUnit.Case

  test "Squid Proxy Req Package" do
    assert ProxyTest.Squid.req_bad() == :bad
    assert ProxyTest.Squid.req_good() == :good
  end

  test "Squid Proxy Finch Package" do
    assert ProxyTest.Squid.finch_bad() == :bad
    assert ProxyTest.Squid.finch_good() == :good
  end

  test "Squid Proxy HTTPoison Package" do
    assert ProxyTest.Squid.httpoison_bad() == :bad
    assert ProxyTest.Squid.httpoison_good() == :good
  end

  test "Squid Proxy Mint Package" do
    assert ProxyTest.Squid.mint_bad() == :bad
    assert ProxyTest.Squid.mint_good() == :good
  end

  test "Tiny Proxy Req Package" do
    assert ProxyTest.Tiny.req_bad() == :bad
    assert ProxyTest.Tiny.req_good() == :good
  end

  test "Tiny Proxy Finch Package" do
    assert ProxyTest.Tiny.finch_bad() == :bad
    assert ProxyTest.Tiny.finch_good() == :good
  end

  test "Tiny Proxy HTTPoison Package" do
    assert ProxyTest.Tiny.httpoison_bad() == :bad
    assert ProxyTest.Tiny.httpoison_good() == :good
  end

  test "Caddy Proxy Req Package" do
    assert ProxyTest.Caddy.req_bad() == :bad
    assert ProxyTest.Caddy.req_good() == :good
  end

  test "Caddy Proxy Finch Package" do
    assert ProxyTest.Caddy.finch_bad() == :bad
    assert ProxyTest.Caddy.finch_good() == :good
  end

  test "Caddy Proxy HTTPoison Package" do
    assert ProxyTest.Caddy.httpoison_bad() == :bad
    assert ProxyTest.Caddy.httpoison_good() == :good
  end

  test "Caddy Proxy Mint Package" do
    assert ProxyTest.Caddy.mint_bad() == :bad
    assert ProxyTest.Caddy.mint_good() == :good
  end
end
