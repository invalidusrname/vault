path "secret" {
  capabilities = ["list"]
}

path "secret/metadata" {
  capabilities = ["list"]
}

path "secret/data/dev/*" {
  capabilities = ["read", "create", "update", "delete"]
}

path "secret/metadata/dev/*" {
  capabilities = ["list", "read"]
}

path "secret/data/test/*" {
  capabilities = ["read", "create", "update", "delete"]
}

path "secret/metadata/test/*" {
  capabilities = ["list", "read"]
}

path "secret/data/staging/*" {
  capabilities = ["deny"]
}

path "secret/metadata/prod/*" {
  capabilities = ["deny"]
}

path "secret/data/prod/*" {
  capabilities = ["deny"]
}

path "secret/metadata/prod/*" {
  capabilities = ["deny"]
}
