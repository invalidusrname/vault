#!/usr/bin/env bash
set -e

echo "Verifying Vault is unsealed"
vault status > /dev/null

for NAMESPACE in dev test staging prod; do
  for F in secret/$NAMESPACE/*.json; do
    NAME=$(basename $F .json)
    SECRET_PATH="secret/$NAMESPACE/$NAME"
    echo "updating $SECRET_PATH"
    cat $F | vault kv put $SECRET_PATH -
  done
done

