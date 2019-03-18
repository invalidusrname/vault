#!/usr/bin/env python

import os
import hvac
import sys

env    = os.environ.get('ENCLAVE', 'test')
token  = os.environ['GITHUB_ACCESS_TOKEN']
vault_url  = os.environ.get('VAULT_URL', 'http://vault.nomadhealth.com')
path   = "secret/environment/" + env + "/nomad_flask"

client = hvac.Client(url=vault_url)
client.auth_github(token)

print("Reading secrets from " + path)

result = client.read(path)

if result is None:
    print "Can't read secrets"
    sys.exit(1)

data = result['data']

config_path = "secrets.sh"

file = open(config_path,"w+")

keys = data.keys()
keys.sort()

for k in keys:
    key = str(k)
    value = str(data[k])
    file.write("export " + key + "=\"" + value + "\"\n")

file.close()

print("appended secrets to " + config_path)
