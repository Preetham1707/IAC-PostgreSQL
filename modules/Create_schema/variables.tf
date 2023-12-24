variable "database_object" {
  type = list(object({
    dbname = string
    dbowner = string 
    dbschema =string
  }))

}