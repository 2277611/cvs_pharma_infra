terraform {
  required_providers {

    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.65.0"
    }
  }

  cloud {
    organization = "CVS-PHARMA-CTS-ITP-KDC"
    workspaces {
      name = "cvs_pharma_infra_core"
    }
  }
}

resource "snowflake_database" "employee_db" {
  name = "CVS_EMPLOYEE_DATA"
  comment = "Created by terraform"
  data_retention_time_in_days = 3
}

resource "snowflake_database" "billing_db" {
  name = "CVS_PROJ_BILLING_DATA"
  comment = "Created by terraform"
  data_retention_time_in_days = 3
}

resource "snowflake_database" "project_db" { 
  name = "CVS_PROJ_DATA"
  comment = "Created by terraform"
  data_retention_time_in_days = 3
}

resource "snowflake_database_grant" "employee_db_grant" {
  database_name = "CVS_EMPLOYEE_DATA"
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
  with_grant_option = true
}

resource "snowflake_database_grant" "billing_db_grant" {
  database_name = "CVS_PROJ_BILLING_DATA"
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
  with_grant_option = true
}

resource "snowflake_database_grant" "project_db_grant" {
  database_name = "CVS_PROJ_DATA"
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
  with_grant_option = true
}

resource "snowflake_schema" "employee_schema" {
  database            = "CVS_EMPLOYEE_DATA"
  name                = "CVS_EMPLOYEE_SCHEMA"
  data_retention_days = 1
}

resource "snowflake_schema" "customer_schema" {
  database            = "CVS_PROJ_BILLING_DATA"
  name                = "CVS_CUSTOMER_SCHEMA"
  data_retention_days = 1
}

resource "snowflake_schema_grant" "employee_schema_grant" {
  database_name = snowflake_schema.employee_schema.database
  schema_name   = snowflake_schema.employee_schema.name
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_schema_grant" "customer_schema_grant" {
  database_name = snowflake_schema.customer_schema.database
  schema_name   = snowflake_schema.customer_schema.name
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_sequence" "employee_sequence" {
  database =  snowflake_schema.employee_schema.database
  schema   = snowflake_schema.employee_schema.name
  name     = "CVS_EMPLOYEE_SEQUENCE"
}

resource "snowflake_sequence" "customer_sequence" {
  database = snowflake_schema.customer_schema.database
  schema   = snowflake_schema.customer_schema.name
  name     = "CVS_CUSTOMER_SEQUENCE"
}

resource "snowflake_sequence_grant" "employee_sequence_grant" {
  database_name = snowflake_schema.employee_schema.database
  schema_name   = snowflake_schema.employee_schema.name
  sequence_name = snowflake_sequence.employee_sequence.name
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_sequence_grant" "customer_sequence_grant" {
  database_name = snowflake_schema.customer_schema.database
  schema_name   = snowflake_schema.customer_schema.name
  sequence_name = snowflake_sequence.customer_sequence.name
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_table" "employee_table" {
  database            = snowflake_database.employee_db.name
  schema              = snowflake_schema.employee_schema.name
  name                = "EMPLOYEE"
  column {
    name     = "employee_EID"
    type     = "INT"
    nullable = false
  }

  column {
    name     = "employee_name"
    type     = "STRING"
    nullable = false
  }

  column {
    name     = "employee_dept"
    type     = "STRING"
    nullable = false
  }

}

resource "snowflake_table" "new_employee_table" {
  database            = snowflake_database.employee_db.name
  schema              = snowflake_schema.employee_schema.name
  name                = "NEW_EMPLOYEE"
  column {
    name     = "employee_id"
    type     = "INT"
    nullable = false
  }

  
  column {
    name     = "employee_name"
    type     = "STRING"
    nullable = false
  }

  column {
    name     = "employee_dept"
    type     = "STRING"
    nullable = false
  }

}

resource "snowflake_table" "customer_table" {
  database            = snowflake_database.project_db.name
  schema              = snowflake_schema.customer_schema.name
  name                = "CUSTOMER_BILLING"
  column {
    name     = "CustID"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "Company"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "Address"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "City"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "State"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "Zip"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "Country"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "Phone"
    type     = "varchar"
    nullable = false
  }

}

resource "snowflake_table_grant" "employee_table_grant" {
  database_name = snowflake_schema.employee_schema.database
  schema_name   = snowflake_schema.employee_schema.name
  table_name    = snowflake_table.employee_table.name
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_table_grant" "new_employee_table_grant" {
  database_name = snowflake_schema.employee_schema.database
  schema_name   = snowflake_schema.employee_schema.name
  table_name    = snowflake_table.new_employee_table.name
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_table_grant" "customer_table_grant" {
  database_name = "CVS_PROJ_BILLING_DATA"
  schema_name   = "CVS_CUSTOMER_SCHEMA"
  table_name    = "CUSTOMER_BILLING"
  privilege = "OWNERSHIP"
  roles     = ["ACCOUNTADMIN"]
}
  