#!/usr/bin/env sh
set -e

echo "Verifying Vault is unsealed"
vault status > /dev/null

echo "Formatting Policies"
for F in policies/*.hcl; do
  vault policy fmt $F
done

echo "Updating Policies"
for F in policies/*.hcl; do
  NAME=$(basename $F .hcl)

  vault policy write $NAME $F
done

set +e
vault auth enable userpass
vault auth enable github
vault secrets list -detailed
vault secrets enable -path=secret -version=2 kv
set -e

vault auth list
vault secrets list -detailed

vault write auth/github/config organization=NomadHealth

vault write auth/github/map/teams/dev value=dev_team
vault write auth/github/map/teams/deploy value=deploy
vault write auth/github/map/users/nomad-circleci value=ci

vault write auth/userpass/users/ci \
    password="FFwwQTT3{JvhYWWatcgAivkkKsLZ" \
    policies=ci

vault write auth/userpass/users/staging-deployer \
    password="TiYfMui6BwWhxfWGXWFhHAB^cwfi" \
    policies=nomad_flask_staging

vault write auth/userpass/users/prod-deployer \
    password="ZiYfMui6BwWhndf8saWFhHAB^iwhx" \
    policies=nomad_flask_prod

source script/write_secrets.sh
