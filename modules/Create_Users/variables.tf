variable "dev_users_with_groups" {
  type = list(object({
    role  = string
    group = string
  }))

}

variable "admin_with_groups" {
  type = list(object({
    role  = string
    group = string
  }))

}

variable "users_without_groups" {
  type = list(object({
    role = string
  }))

}


variable "app_admin_users" {
  type = list(object({
    role  = string
   createrole = bool
   login=bool
  }))

}


variable "app_non_admin_users" {
  type = list(object({
    role  = string
    createrole = bool
    login=bool
  }))

}

variable "environment" {
  type = string
}