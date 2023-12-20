###########################################################################################
#  USERS
###########################################################################################
users = {
  Minato = {
    environment = ["dev", "staging", "production"]
    is_admin : true
  }
  Naruto = {
    environment = ["dev", "staging"]
    is_admin : false
  }

  Sasuke = {
    environment = ["dev", "staging"]
    is_admin : false
  }

  Obito = {
    environment = ["dev", "staging", "production"]
    is_admin : true
  }
  Itachi = {
    environment = ["dev", "staging"]
    is_admin : false
  }

  Nagato = {
    environment = ["dev", "staging"]
    is_admin : false
  }
  gaara = {
    environment = ["dev", "staging", "production"]
    is_admin : true
  }
  Temari = {
    environment = ["dev", "staging"]
    is_admin : false
  }
  MightGuy = {
    environment = ["dev", "staging"]
    is_admin : false
  }

  Shikamaru = {
    environment = ["dev", "staging"]
    is_admin : false
  }
}

###########################################################################################
#GROUPS
###########################################################################################
groups = {

  Leaf_village = {
    name = "leaf_village"
    users = {
      Minato = { name = "Minato", environments = ["dev", "staging", "production"] }
      Naruto = { name = "Naruto", environments = ["dev", "staging"] }
      Sasuke = { name = "sasuke", environments = ["dev", "staging"] }
    }
  }

  sand_village = {
    name = "sand_village"
    users = {
      gaara  = { name = "gaara", environments = ["dev", "staging", "production"] }
      Temari = { name = "Temari", environments = ["dev", "staging"] }
    }
  }

  ex_leafVillage = {
    name = "ex_leafVillage"
    users = {
      Obito  = { name = "Obito", environments = ["dev", "staging", "production"] }
      Itachi = { name = "Itachi", environments = ["dev", "staging"] }
      # Sasuke = { name = "sasuke", environments = ["dev", "staging"] }
    }
  }


}


###########################################################################################
#DB
###########################################################################################
Databases = {
  app1 = {
    db_schema_name = "app1Schmea"
    db_name        = "app1"
    db_admin       = "app1_admin_role"
    db_roles = [
      { id = "admin", role = "app1_admin_role", inherit = true, login = false, validity = "infinity", privileges = ["USAGE", "CREATE"], createrole = true },
      { id = "readonly", role = "app1_readonly_role", inherit = true, login = false, validity = "infinity", privileges = ["USAGE"], createrole = false },
      { id = "write", role = "app1_write_role", inherit = true, login = false, validity = "infinity", privileges = ["USAGE"], createrole = false },

    ]
    db_grants = [
      # role app_admin_role : define grants to apply on db 'mydatabase', schema 'public'
      { object_type = "database", privileges = ["CREATE", "CONNECT", "TEMPORARY"], objects = [], role = "app1_admin_role", owner_role = "postgres", grant_option = true },
      { object_type = "type", privileges = ["USAGE"], objects = [], role = "app1_admin_role", owner_role = "postgres", grant_option = true },

      # role app_readonly_role : define grant to apply on db 'mydatabase', schema 'public'  
      { object_type = "database", privileges = ["CONNECT"], objects = [], role = "app1_readonly_role", owner_role = "app1_admin_role", grant_option = false },
      { object_type = "type", privileges = ["USAGE"], objects = [], role = "app1_readonly_role", owner_role = "app1_admin_role", grant_option = true },
      { object_type = "table", privileges = ["SELECT", "REFERENCES", "TRIGGER"], objects = [], role = "app1_readonly_role", owner_role = "app1_admin_role", grant_option = false },
      { object_type = "sequence", privileges = ["SELECT", "USAGE"], objects = [], role = "app1_readonly_role", owner_role = "app1_admin_role", grant_option = false },

      # role app_write_role : define grant to apply on db 'mydatabase', schema 'public'
      { object_type = "database", privileges = ["CONNECT"], objects = [], role = "app1_write_role", owner_role = "app1_admin_role", grant_option = false },
      { object_type = "type", privileges = ["USAGE"], objects = [], role = "app1_write_role", owner_role = "app1_admin_role", grant_option = true },
      { object_type = "table", privileges = ["SELECT", "REFERENCES", "TRIGGER", "INSERT", "UPDATE", "DELETE"], objects = [], role = "app1_write_role", owner_role = "app1_admin_role", grant_option = false },
      { object_type = "sequence", privileges = ["SELECT", "USAGE"], objects = [], role = "app1_write_role", owner_role = "app1_admin_role", grant_option = false },
      { object_type = "function", privileges = ["EXECUTE"], objects = [], role = "app1_write_role", owner_role = "app1_admin_role", grant_option = false },

    ]
  }

}