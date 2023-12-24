terraform {
  backend "pg" {
    conn_str = "postgres://kakashi:Chidori@1234@54.241.97.63:5432/terrapost"


  }
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.5.0"
    }

    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
  }
}

# variable "ROLE_ID" {
#   sensitive = true
# }

# variable "Username" {
#   type = string
#   default = "kakashi"
#   description = "Username Information from vault"
#   sensitive = true

# }

# variable "SECRET_ID" {
#   sensitive = true
# }


# provider "vault" {
#   address          = "http://172.191.166.158:8200/"
#   skip_child_token = true

#   auth_login {
#     path = "auth/approle/login"

#     parameters = {
#       role_id   = var.ROLE_ID
#       secret_id = var.SECRET_ID
#     }
#   }
# }

# data "vault_generic_secret" "database_inputs" {
#   path = "terrafetch/terraRead"

# }

provider "postgresql" {
  host            = "254c3a0b861c.mylabserver.com"
  port            = 5432
  database        = "terrapost"
  username        = "postgres"
  password        = "Chidori@1234"
  connect_timeout = 15
}


locals {
  environment          = "dev"
  dev_user_keys        = keys(local.dev_users)
  admin_user_keys      = keys(local.dev_admin_users)
  dev_group_users_keys = [for user in local.dev_group_users : user.role]
  no_group_users_keys  = setsubtract(local.dev_user_keys, local.dev_group_users_keys)



  dev_users = {
    for name, user in var.users : name => user
    if contains(var.users[name].environment, local.environment) && !user.is_admin
  }

  dev_admin_users = {
    for name, user in var.users : name => user
    if contains(var.users[name].environment, local.environment) && user.is_admin
  }


  dev_group_users = flatten([
    for group_name, group_data in local.dev_groups : [
      for user_name, user_data in local.dev_users :
      {
        role  = user_name
        group = group_name
      } if contains(keys(group_data.users), user_name)
    ]

  ])

  admin_group_users = flatten([
    for group_name, group_data in local.dev_groups : [
      for user_name, user_data in local.dev_admin_users :
      {
        role  = user_name
        group = group_name
      } if contains(keys(group_data.users), user_name)
    ]

  ])

  general_users = flatten([
    for users in local.no_group_users_keys : {
      role = users
    }
  ])


  dev_groups = {
    for group, data in var.groups : group => {
      name = data.name
      users = {
        for user, user_data in data.users : user => {
          name = user_data.name
        }
        if contains(user_data.environments, local.environment)
      }
    }
  }

  app_admin_users = flatten([
    for appuser, appdata in var.Databases : [
      for dbroles, data in appdata.db_roles : {
        role       = data.role
        createrole = data.createrole
        login      = data.login
      } if data.id == "admin"
    ]
  ])

  app_non_admin_users = flatten([
    for appuser, appdata in var.Databases : [
      for dbroles, data in appdata.db_roles : {
        role       = data.role
        createrole = data.createrole
        login      = data.login
      } if data.id != "admin"
    ]
  ])


  app_database = flatten([
    for database, database_data in var.Databases : {
      dbname   = database_data.db_name
      dbowner  = database_data.db_admin
      dbschema = database_data.db_schema_name
    }
  ])

  app_db_grants =flatten([
    for appuser, appdata in var.Databases : [
      for dbgrants, data in appdata.db_grants : {
        object_type = data.object_type
        privileges =  data.privileges
        objects = data.objects
        role =data.role
        owner_role =data.owner_role
        grant_option = data.grant_option
        dbname = appdata.db_name
        dbschema = appdata.db_schema_name

      } if data.object_type != "database"
    ]
  ])


}






module "create_groups" {
  source = "../modules/Create_groups"

  #Input Variable
  environment = local.environment
  dev_groups  = local.dev_groups


}

module "create_role" {
  source = "../modules/Create_Users"

  #Input Variable
  environment           = local.environment
  dev_users_with_groups = local.dev_group_users
  users_without_groups  = local.general_users
  admin_with_groups     = local.admin_group_users
  app_admin_users       = local.app_admin_users
  app_non_admin_users   = local.app_non_admin_users
  depends_on            = [module.create_groups]
}


module "create_database" {
  source = "../modules/Create_database"

  #Input Variable
  database_object = local.app_database
  depends_on      = [module.create_role]

}

module "create_schema" {
  source = "../modules/Create_schema"

  #Input variable 
  database_object = local.app_database
  depends_on      = [module.create_database]

}

module "Grant_priviliges" {
  source = "../modules/Grant-privileges"

  #Input Variable
  db_grants = local.app_db_grants
  depends_on = [ module.create_schema ]
  
}

