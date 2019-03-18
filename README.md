# Vault README

This repository serves as the single source of truth for the storage of secrets
used by our apps.  Data items such as database passwords, api keys,
etc are all stored in configuration management here for auditing and
collaborative purposes.

It is *vitally* important that this repository remain private as the sensitive
information is critical to the security of the site. Here, we rely on github's
security to guarantee authorization to this confidential data.

## Directory Structure

    secret/<ENV>/<APP_NAME>.json

Example:

    secret/
    |── dev
    │   ├── common.json
    │   ├── nomad_flask.json
    ├── prod
    │   ├── common.json
    │   ├── nomad_flask.json
    ├── test
    │   ├── common.json
    │   ├── nomad_flask.json

## Environment Variables

The following environment variables need to be setup for the app to function:

For changes to production instance of Vault:

    $ export VAULT_ADDR='https://vault.nomadhealth.com:8200'
    $ export VAULT_TOKEN='CHANGEME'
    $ ./script/write_secrets.sh

## Setting up locally

    $ docker-compose up
    $ docker-compose exec vault /bin/sh
    # export VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN_ID; cd /app; ./script/provision.sh
