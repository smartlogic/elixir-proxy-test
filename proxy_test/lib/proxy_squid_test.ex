defmodule ProxyTest.Squid do
  @moduledoc """
  Documentation for `ProxyTest.Squid`.
  """

  def connection_options do
    auth64 = Base.encode64("test:password")

    [
      protocols: [:http1],
      proxy: {:http, "127.0.0.1", 3128, []},
      proxy_headers: [{"Proxy-Authorization", "Basic #{auth64}"}]
    ]
  end

  def httpoison_options do
    [
      proxy: {"127.0.0.1", 3128},
      proxy_auth: {"test", "password"}
    ]
  end

  @doc """
  Proxy with mint to something not allowed
  """
  def mint_bad do
    case Mint.HTTP.connect(:https, "yahoo.com", 443, connection_options()) do
      {:error,
       %Mint.HTTPError{reason: {:proxy, {:unexpected_status, 403}}, module: Mint.TunnelProxy}} ->
        :bad

      _ ->
        :error
    end
  end

  @doc """
  Proxy with mint to something allowed
  """
  def mint_good do
    case Mint.HTTP.connect(:https, "www.google.com", 443, connection_options()) do
      {:ok, conn} ->
        case Mint.HTTP.request(conn, "GET", "/", [], nil) do
          {:ok, _, _} ->
            :good

          _ ->
            :error
        end

      _ ->
        :error
    end
  end

  @doc """
  Proxy with httpoison to something not allowed
  """
  def httpoison_bad do
    case HTTPoison.get("https://yahoo.com", [], httpoison_options()) do
      {:ok, _} ->
        :error

      {:error, %HTTPoison.Error{reason: :proxy_error, id: nil}} ->
        :bad
    end
  end

  @doc """
  Proxy with httpoison to something allowed
  """
  def httpoison_good do
    case HTTPoison.get("https://www.google.com", [], httpoison_options()) do
      {:ok, _} ->
        :good

      _ ->
        :error
    end
  end

  @doc """
  Proxy with req to something not allowed
  """
  def req_bad do
    try do
      Req.get!(
        "https://yahoo.com",
        connect_options: connection_options()
      )

      :error
    rescue
      _e in Mint.HTTPError ->
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
        :good

      200 ->
        :good

      _ ->
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
      {:ok, _resp} ->
        :error

      {:error,
       %Mint.HTTPError{reason: {:proxy, {:unexpected_status, 403}}, module: Mint.TunnelProxy}} ->
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
      {:ok, _resp} ->
        :good

      {:error, _e} ->
        :error
    end
  end
end
