defmodule ProxyTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ProxyTest.Worker.start_link(arg)
      # {ProxyTest.Worker, arg}
      {Finch,
       name: SquidFinch,
       pools: %{
         :default => [
           size: 5,
           conn_opts: [
             protocols: [:http1],
             proxy: {:http, "127.0.0.1", 3128, []}
           ]
         ]
       }},
      {Finch,
       name: TinyFinch,
       pools: %{
         :default => [
           size: 5,
           conn_opts: [
             protocols: [:http1],
             proxy: {:http, "127.0.0.1", 8081, []}
           ]
         ]
       }},
      {Finch,
       name: CaddyFinch,
       pools: %{
         :default => [
           size: 5,
           conn_opts: [
             protocols: [:http1],
             proxy: {:http, "127.0.0.1", 8080, []}
           ]
         ]
       }}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProxyTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
