#!/bin/bash

if [ "$VAULT_ROOT_TOKEN" == "" ]; then
  export VAULT_ROOT_TOKEN="dev-token"
fi

if [ "$VAULT_ADDR" == "" ]; then
  export VAULT_ADDR="http://127.0.0.1:8200"
fi

SERVER_OPTS="-dev -dev-root-token-id=$VAULT_DEV_ROOT_TOKEN"

if [ "$1" == "CI" ]; then
  echo $SERVER_OPTS
  nohup vault server $SERVER_OPTS > logs/vault.out 2>&1 &
else
  echo $SERVER_OPTS
  vault server $SERVER_OPTS
fi
