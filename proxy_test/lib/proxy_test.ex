defmodule ProxyTest do
  @moduledoc """
  Documentation for `ProxyTest`.
  """

  def connection_options_tiny do
    [
      protocols: [:http1],
      # proxy_headers: [{"Proxy-Connection", "Keep-Alive"}],
      proxy: {:http, "127.0.0.1", 8081, []}
    ]
  end

  def connection_options_caddy do
    [
      protocols: [:http1],
      # proxy_headers: [{"Proxy-Connection", "Keep-Alive"}],
      proxy: {:http, "127.0.0.1", 8080, []}
    ]
  end

  @doc """
  Proxy with req to something not allowed
  """
  def req_tiny_bad do
    try do
      resp =
        Req.get!(
          "https://yahoo.com",
          connect_options: connection_options_tiny()
        )

      IO.puts(resp.status)
      IO.puts("UNEXEPECTED allowed")
    rescue
      _e in Mint.HTTPError ->
        IO.puts("blocked as expected")
    end
  end

  @doc """
  Proxy with req to something allowed
  """
  def req_tiny_good do
    resp =
      Req.get!(
        "https://www.google.com",
        connect_options: connection_options_tiny()
      )

    case resp.status do
      302 ->
        IO.puts(resp.status)
        :ok

      200 ->
        IO.puts(resp.status)
        :ok

      _ ->
        IO.puts("UNEXEPECTED blocked")
        :error
    end
  end

  @doc """
  Proxy with finch to something not allowed
  """
  def finch_tiny_bad do
    response =
      Finch.build(:get, "https://yahoo.com")
      |> Finch.request(TinyFinch)

    case response do
      {:ok, resp} ->
        IO.puts(resp.status)
        IO.puts("UNEXEPECTED allowed")
        :error

      {:error,
       %Mint.HTTPError{reason: {:proxy, {:unexpected_status, 403}}, module: Mint.TunnelProxy}} ->
        IO.puts("blocked as expected")
        :ok
    end
  end

  @doc """
  Proxy with finch to something allowed
  """
  def finch_tiny_good do
    response =
      Finch.build(:get, "https://www.google.com")
      |> Finch.request(TinyFinch)

    case response do
      {:ok, resp} ->
        IO.puts(resp.status)
        :ok

      {:error, _e} ->
        IO.puts("UNEXEPECTED blocked")
        :error
    end
  end
end
