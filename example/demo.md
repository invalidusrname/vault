# Vault

* [Getting Started](https://learn.hashicorp.com/vault/#getting-started)
* [Docs](https://www.vaultproject.io/docs)

## Setting up locally

Builds vault and seeds it with some policies and secrets

    $ docker-compose up
    $ docker-compose exec vault /bin/sh
    # cd /app && VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN_ID ./script/provision.sh

### Logging in via github

Allows logging in via github

    # vault login -method=github token=$GITHUB_ACCESS_TOKEN
    # export VAULT_TOKEN=PASTE_FROM_LAST_COMMAND

### Accessing resources

A few allowed ones:

    # vault kv get /secret/dev/common
    # vault kv list /secret/dev
    # vault kv get -format=json secret/dev/common | jq ".data[]"

A few ones that aren't allowed:

    # vault kv get /secret/prod/common
    # vault kv list /secret/prod
    
    # vault kv get -format=json secret/dev/my_app | jq ".data[]"

### Demo writing to a key-value store (V2)

    # export VAULT_TOKEN=dev-token
    # vault kv put /secret/test/somepath swamp=thing
    # vault kv get -format=json /secret/test/somepath

### Demo dynamic credentials

Setup a database

    $ docker-compose exec db /bin/bash
    # psql -U postgres
    =# CREATE DATABASE sample_db;
    =# \l

Configure vault to work with postgres

    $ docker-compose exec vault /bin/bash
    # vault secrets list
    # vault secrets enable database

Setup connection string

    # vault write database/config/sample_db \
    plugin_name=postgresql-database-plugin \
    allowed_roles="my-role,short-role" \
    connection_url="postgresql://{{username}}:{{password}}@db:5432/?sslmode=disable" \
    username="postgres" \
    password="PASSWORDO"

Showing a login that works for 1h

    # vault write database/roles/my-role \
    db_name=sample_db \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"

Actually create the login

    # vault read database/creds/my-role

Showing a login that only works for 10 seconds

    # vault write database/roles/short-role \
    db_name=sample_db \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl="10s" \
    max_ttl="24h"

Actually create the login

    vault read database/creds/short-role

    $ docker-compose exec db /bin/bash
    # psql -U CHANGE_TO_THE_USER_TOKEN
