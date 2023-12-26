variable "users" {
  type = map(object({
    environment = list(string)
    is_admin    = bool
    applications = list(string)
  }))
}



variable "groups" {
  type = map(object({
    name = string
    users = map(object({
      name         = string
      environments = list(string)
    }))
  }))
}


variable "Databases" {
  type = map(object({
    db_schema_name = string
    db_name        = string
    db_admin       = string
    db_roles = list(object({
      id         = string
      role       = string
      inherit    = bool
      login      = bool
      validity   = string
      privileges = list(string)
      createrole = bool

      }
    ))
    db_grants = list(object({
      object_type  = string
      privileges   = list(string)
      objects      = list(string)
      role         = string
      owner_role   = string
      grant_option = bool
    }))
  }))
}



