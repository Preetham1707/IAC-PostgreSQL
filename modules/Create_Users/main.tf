terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}

resource "postgresql_role" "adminuserwithgroups" {
  count              = length(var.admin_with_groups)
  name               = var.admin_with_groups[count.index].role
  login              = true
  password           = "user@1234"
  roles              = [var.admin_with_groups[count.index].group]
  encrypted_password = true
  superuser = true


}


resource "postgresql_role" "createuserwithgroups" {
  count              = length(var.dev_users_with_groups)
  name               = var.dev_users_with_groups[count.index].role
  login              = true
  password           = "user@1234"
  roles              = [var.dev_users_with_groups[count.index].group]
  encrypted_password = true


}

resource "postgresql_role" "createuserwithoutgroups" {
  count              = length(var.users_without_groups)
  name               = var.users_without_groups[count.index].role
  login              = true
  password           = "user@1234"
  encrypted_password = true

}


resource "postgresql_role" "app_admin_users" {
  count              = length(var.app_admin_users)
  name               = var.app_admin_users[count.index].role
  login              = var.app_admin_users[count.index].login
  create_role        = var.app_admin_users[count.index].createrole
  password           = "user@1234"
  encrypted_password = true

}



resource "postgresql_role" "app_non_admin_users" {
  count              = length(var.app_non_admin_users)
  name               = var.app_non_admin_users[count.index].role
  login              = var.app_non_admin_users[count.index].login
  create_role        = var.app_non_admin_users[count.index].createrole
  password           = "user@1234"
  encrypted_password = true

}