defmodule ProxyTest.CaddyProxy.Finch do
  @doc """
  Proxy with finch to something not allowed
  """
  def bad_request do
    response =
      Finch.build(:get, "https://yahoo.com")
      |> Finch.request(CaddyFinch)

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
  def good_request do
    response =
      Finch.build(:get, "https://www.google.com")
      |> Finch.request(CaddyFinch)

    case response do
      {:ok, _resp} ->
        :good

      {:error, _e} ->
        :error
    end
  end
end
