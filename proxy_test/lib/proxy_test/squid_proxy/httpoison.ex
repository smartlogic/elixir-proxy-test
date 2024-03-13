defmodule ProxyTest.SquidProxy.HTTPoison do
  @doc """
  Proxy with httpoison to something not allowed
  """
  def bad_request do
    case HTTPoison.get("https://yahoo.com", [], ProxyTest.SquidProxy.httpoison_options()) do
      {:ok, _} ->
        :error

      {:error, %HTTPoison.Error{reason: :proxy_error, id: nil}} ->
        :bad
    end
  end

  @doc """
  Proxy with httpoison to something allowed
  """
  def good_request do
    case HTTPoison.get("https://www.google.com", [], ProxyTest.SquidProxy.httpoison_options()) do
      {:ok, _} ->
        :good

      _ ->
        :error
    end
  end
end
