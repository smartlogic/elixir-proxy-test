# Elixir Examples for Proxy Config

This demonstrates various Elixir libraries connecting to authorized domains based on a basic authenticated proxy.

## Proxies Tested

1. [Caddy](https://caddyserver.com/)
2. [Squid](https://www.squid-cache.org/)
3. [Tinyproxy](http://tinyproxy.github.io/)

## Libraries Tested

1. [Finch](https://github.com/sneako/finch) uses Mint
2. [Req](https://github.com/wojtekmach/req) uses Finch and thus Mint
3. [Mint](https://github.com/elixir-mint/mint)
4. [HTTPoison](https://github.com/edgurgel/httpoison) uses Hackney

## Notes

Caddy with anything based on Mint seems to not work due to a "tunnel proxy returned unexpected trailer responses" error. Caddy works when using Hackney based connections with HTTPoison, which means Tesla might work.

The Mint based libraries don't seem to struggle with the Squid or Tinyproxy server

## Developing

1. Install Elixir, tested with 1.14 on OTP 25 currently
2. Run `mix test`
