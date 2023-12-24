terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}

resource "postgresql_default_privileges" "read_only_tables" {
  role        = "test_role"
  database    = "test_db"
  schema      = "public"
  owner       = "db_owner"
  object_type = "table"
  privileges  = ["SELECT"]
}