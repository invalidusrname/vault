# Vault README

This demo repository serves as the single source of truth for the storage of secrets.
Data items such as database passwords, api keys, etc are all stored in 
configuration management here for auditing and collaborative purposes.

## Directory Structure

    secret/<ENV>/<APP_NAME>.json

Example:

    secret/
    |── dev
    │   ├── common.json
    │   ├── my_app.json
    ├── prod
    │   ├── common.json
    │   ├── my_app.json
    ├── test
    │   ├── common.json
    │   ├── my_app.json

## Environment Variables

The following environment variables need to be setup for the app to function:

For changes to production instance of Vault:

    $ export VAULT_ADDR='https://localhost:8200'
    $ export VAULT_TOKEN='CHANGEME'
    $ ./script/write_secrets.sh

## Setting up locally

    $ docker-compose up
    $ docker-compose exec vault /bin/sh
    # cd /app && VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN_ID ./script/provision.sh

### Reading some stuff

    # vault kv list secret/dev
    # apk add jq
    # vault kv get -format=json secret/dev/my_app | jq ".data[]"

