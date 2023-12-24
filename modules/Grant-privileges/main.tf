terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}

resource "postgresql_default_privileges" "read_only_tables" {
  count    = length(var.db_grants)
  role        = var.db_grants[count.index].role
  database    = var.db_grants[count.index].dbname
  schema      = var.db_grants[count.index].dbschema
  owner       = var.db_grants[count.index].owner_role
  object_type = var.db_grants[count.index].object_type
  privileges  = var.db_grants[count.index].privileges
}