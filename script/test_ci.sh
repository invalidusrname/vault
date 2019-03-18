#!/bin/bash

set -e

export VAULT_TOKEN=$(vault login -method=userpass -token-only username=ci password=ci)

vault status > /dev/null

vault kv list secret/test
vault kv get secret/test/common
vault kv get secret/test/nomad_flask
