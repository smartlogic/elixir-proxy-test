defmodule ProxyTest.TinyProxy do
  @moduledoc """
  Documentation for `ProxyTest.TinyProxy`.
  """

  def connection_options do
    auth64 = Base.encode64("test:password")

    [
      protocols: [:http1],
      proxy: {:http, "127.0.0.1", 8081, []},
      proxy_headers: [{"Proxy-Authorization", "Basic #{auth64}"}]
    ]
  end

  def httpoison_options do
    [
      proxy: {"127.0.0.1", 8081},
      proxy_auth: {"test", "password"}
    ]
  end
end
