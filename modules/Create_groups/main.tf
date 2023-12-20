terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}




resource "postgresql_role" "dbGroups" {
  for_each    = var.dev_groups
  name        = each.key
  login       = false
  valid_until = "infinity"
  lifecycle {
    ignore_changes = [roles]
  }

}

