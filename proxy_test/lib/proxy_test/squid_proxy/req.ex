defmodule ProxyTest.SquidProxy.Req do
  @doc """
  Proxy with req to something not allowed
  """
  def bad_request do
    try do
      Req.get!(
        "https://yahoo.com",
        connect_options: ProxyTest.SquidProxy.connection_options()
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
  def good_request do
    resp =
      Req.get!(
        "https://www.google.com",
        connect_options: ProxyTest.SquidProxy.connection_options()
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
end
