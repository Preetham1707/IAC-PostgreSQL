###########################################################################################
#  USERS
###########################################################################################
users = {
  Minato = {
    environment = ["dev", "staging", "production"]
    is_admin : true
    applications = ["app1" , "app2"]
  }
  Naruto = {
    environment = ["dev"]
    is_admin : false
    applications = ["app1"]
  }

  Sasuke = {
    environment = ["staging"]
    is_admin : false
    applications = ["app2"]
  }

  Obito = {
    environment = ["dev", "staging", "production"]
    is_admin : true
    applications = ["app1" , "app2"]
  }
  Itachi = {
    environment = ["dev"]
    is_admin : false
     applications = ["app1"]
  }

  Nagato = {
    environment = ["staging"]
    is_admin : false
    applications = ["app2"]
  }
  gaara = {
    environment = ["dev", "staging", "production"]
    is_admin : true
    applications =[]
  }
  Temari = {
    environment = ["dev", "staging"]
    is_admin : false
    applications =[]
  }
  MightGuy = {
    environment = ["staging"]
    is_admin : false
    applications =[]
  }

  Shikamaru = {
    environment = ["dev"]
    is_admin : false
    applications =[]
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
      Naruto = { name = "Naruto", environments = ["dev"] }
      Sasuke = { name = "sasuke", environments = ["staging"] }
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
      Itachi = { name = "Itachi", environments = ["dev"] }
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
  },

  app2 = {
    db_schema_name = "app2Schmea"
    db_name        = "app2"
    db_admin       = "app2_admin_role"
    db_roles = [
      { id = "admin", role = "app2_admin_role", inherit = true, login = false, validity = "infinity", privileges = ["USAGE", "CREATE"], createrole = true },
      { id = "readonly", role = "app2_readonly_role", inherit = true, login = false, validity = "infinity", privileges = ["USAGE"], createrole = false },
      { id = "write", role = "app2_write_role", inherit = true, login = false, validity = "infinity", privileges = ["USAGE"], createrole = false },

    ]
    db_grants = [
      # role app_admin_role : define grants to apply on db 'mydatabase', schema 'public'
      { object_type = "database", privileges = ["CREATE", "CONNECT", "TEMPORARY"], objects = [], role = "app2_admin_role", owner_role = "postgres", grant_option = true },
      { object_type = "type", privileges = ["USAGE"], objects = [], role = "app2_admin_role", owner_role = "postgres", grant_option = true },

      # role app_readonly_role : define grant to apply on db 'mydatabase', schema 'public'  
      { object_type = "database", privileges = ["CONNECT"], objects = [], role = "app2_readonly_role", owner_role = "app2_admin_role", grant_option = false },
      { object_type = "type", privileges = ["USAGE"], objects = [], role = "app2_readonly_role", owner_role = "app2_admin_role", grant_option = true },
      { object_type = "table", privileges = ["SELECT", "REFERENCES", "TRIGGER"], objects = [], role = "app2_readonly_role", owner_role = "app2_admin_role", grant_option = false },
      { object_type = "sequence", privileges = ["SELECT", "USAGE"], objects = [], role = "app2_readonly_role", owner_role = "app2_admin_role", grant_option = false },

      # role app_write_role : define grant to apply on db 'mydatabase', schema 'public'
      { object_type = "database", privileges = ["CONNECT"], objects = [], role = "app2_write_role", owner_role = "app2_admin_role", grant_option = false },
      { object_type = "type", privileges = ["USAGE"], objects = [], role = "app2_write_role", owner_role = "app2_admin_role", grant_option = true },
      { object_type = "table", privileges = ["SELECT", "REFERENCES", "TRIGGER", "INSERT", "UPDATE", "DELETE"], objects = [], role = "app2_write_role", owner_role = "app2_admin_role", grant_option = false },
      { object_type = "sequence", privileges = ["SELECT", "USAGE"], objects = [], role = "app2_write_role", owner_role = "app2_admin_role", grant_option = false },
      { object_type = "function", privileges = ["EXECUTE"], objects = [], role = "app2_write_role", owner_role = "app2_admin_role", grant_option = false },

    ]
  }


}