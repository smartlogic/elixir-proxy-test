# Elixir Proxy Testing

This repo sets up 3 different proxy services with Docker and Docker Compose to allow local testing of various configurations and Elixir libraries for making HTTPS requests.

## Details

1. [Caddy](https://caddyserver.com/) on port 8080
2. [Squid](https://www.squid-cache.org/) on port 3128
3. [Tinyproxy](http://tinyproxy.github.io/) on port 8081

## Testing

All 3 proxies can be built and run with Docker and Docker Compose.

1. run `docker compose build` to build the images
2. run `docker compose up` to bring up all 3 containers
3. Use Control-C twice to stop, the second Control-C is due to how Squid is currently configured.

See the Elixir library with tests in the `proxy_test` folder for examples of code interacting with these proxies.

## Notes

1. Elixir does not support an HTTPS connection to the proxy server to then send the CONNECT command if the target connection is also HTTPS. This should not be a strict requirement as the actual payloads will be encrypted after the initial CONNECT request, which would be decrypted by an HTTPS proxy anyway. This also means that in a cloud environment with secure Container to Container traffic, the proxy would need to not operate with that configuration and use a different port.
2. The hardcoded user/password would need to be moved to a more secure and rotatable approach. This may be less feasible with the Squid and Tinyproxy approaches, as they may not be dynamically configurable out of the box, but an approach at container boot could potentially address the issue.

