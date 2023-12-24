terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}



resource "postgresql_schema" "DB_schema" {
  count    = length(var.database_object)
  name     = var.database_object[count.index].dbschema
  database = var.database_object[count.index].dbname
  owner    = var.database_object[count.index].dbowner
}