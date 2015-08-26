#!/bin/bash

echo "Running $(ipfs version)..."

if [ -e /ipfs/config ]; then
  echo "Found ipfs repository. Not initializing."
else
  ipfs init
  ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
  ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
  ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
  # ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://localhost", "http://127.0.0.1", "http://mydomainname"]'
  # ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://localhost:<port>", "http://127.0.0.1:<port>", "http://mydomainname:<port>"]'
fi

ipfs daemon