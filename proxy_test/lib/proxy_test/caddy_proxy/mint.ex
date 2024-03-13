defmodule ProxyTest.CaddyProxy.Mint do
  @doc """
  Proxy with mint to something not allowed
  """
  def bad_request do
    case Mint.HTTP.connect(:https, "yahoo.com", 443, ProxyTest.CaddyProxy.connection_options()) do
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
  def good_request do
    case Mint.HTTP.connect(
           :https,
           "www.google.com",
           443,
           ProxyTest.CaddyProxy.connection_options()
         ) do
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
end
