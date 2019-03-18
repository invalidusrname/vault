path "secret/data/test/*" {
  capabilities = ["read"]
}

path "secret/metadata/test/*" {
  capabilities = ["list", "read"]
}
