path "secret" {
  capabilities = ["list"]
}

path "secret/metadata" {
  capabilities = ["list"]
}

path "secret/data/prod/common" {
  capabilities = ["read"]
}

path "secret/metadata/prod/common" {
  capabilities = ["list", "read"]
}

path "secret/data/prod/nomad_flask" {
  capabilities = ["read"]
}

path "secret/metadata/prod/nomad_flask" {
  capabilities = ["list", "read"]
}
