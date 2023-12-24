variable "db_grants" {
    type = list(object({
        object_type = string
        privileges =  list(string)
        objects = list(string)
        role = string
        owner_role = string
        grant_option = bool
        dbname = string
        dbschema = string
    }))
  
}