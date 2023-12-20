variable "dev_groups" {
  type = map(object({
    name = string
    users = map(object({
      name = string
    }))
  }))

}


variable "environment" {
  type = string
}