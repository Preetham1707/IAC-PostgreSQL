terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}




resource "postgresql_database" "createDatabase" {
  count             = length(var.database_object)
  name              = var.database_object[count.index].dbname
  owner             = var.database_object[count.index].dbowner
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}