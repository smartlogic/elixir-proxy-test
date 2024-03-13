defmodule ProxyTest.Squid do
  @moduledoc """
  Documentation for `ProxyTest.Squid`.
  """

  def connection_options do
    [
      protocols: [:http1],
      proxy: {:http, "127.0.0.1", 3128, []}
    ]
  end

  @doc """
  Proxy with req to something not allowed
  """
  def req_bad do
    try do
      resp =
        Req.get!(
          "https://yahoo.com",
          connect_options: connection_options()
        )

      IO.puts(resp.status)
      IO.puts("UNEXEPECTED allowed")
      :error
    rescue
      _e in Mint.HTTPError ->
        IO.puts("blocked as expected")
        :bad
    end
  end

  @doc """
  Proxy with req to something allowed
  """
  def req_good do
    resp =
      Req.get!(
        "https://www.google.com",
        connect_options: connection_options()
      )

    case resp.status do
      302 ->
        IO.puts(resp.status)
        :good

      200 ->
        IO.puts(resp.status)
        :good

      _ ->
        IO.puts("UNEXEPECTED blocked")
        :error
    end
  end

  @doc """
  Proxy with finch to something not allowed
  """
  def finch_bad do
    response =
      Finch.build(:get, "https://yahoo.com")
      |> Finch.request(SquidFinch)

    case response do
      {:ok, resp} ->
        IO.puts(resp.status)
        IO.puts("UNEXEPECTED allowed")
        :error

      {:error,
       %Mint.HTTPError{reason: {:proxy, {:unexpected_status, 403}}, module: Mint.TunnelProxy}} ->
        IO.puts("blocked as expected")
        :bad
    end
  end

  @doc """
  Proxy with finch to something allowed
  """
  def finch_good do
    response =
      Finch.build(:get, "https://www.google.com")
      |> Finch.request(SquidFinch)

    case response do
      {:ok, resp} ->
        IO.puts(resp.status)
        :good

      {:error, _e} ->
        IO.puts("UNEXEPECTED blocked")
        :error
    end
  end
end
