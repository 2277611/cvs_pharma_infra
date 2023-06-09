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
resource "snowflake_warehouse" "cvs_warehouse" {
  name           = "CVS_WH"
  warehouse_size = "LARGE"
  auto_suspend   = 600
}

resource "snowflake_warehouse_grant" "CVS_WH_grant" {
  warehouse_name = "CVS_WH"
  privilege      = "ALL PRIVILEGES"
  roles = ["ACCOUNTADMIN","ORGADMIN"]
} 

resource "snowflake_database" "employee_db" {
  name = "CVS_EMPLOYEE_DATA"
  comment = "Created by terraform"
  data_retention_time_in_days = 7
  
}

resource "snowflake_database_grant" "employee_db_grant" {
  database_name = snowflake_database.employee_db.name
  privilege = "USAGE"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
  with_grant_option = true
}

resource "snowflake_schema" "employee_schema" {
  database            = snowflake_database.employee_db.name
  name                = "CVS_EMPLOYEE_SCHEMA"
  data_retention_days = 7
}

resource "snowflake_schema_grant" "employee_schema_grant" {
  database_name = snowflake_database.employee_db.name
  schema_name   = snowflake_schema.employee_schema.name
  privilege = "SELECT"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_sequence" "employee_sequence" {
  database =  snowflake_database.employee_db.name
  schema   = snowflake_schema.employee_schema.name
  name     = "CVS_EMPLOYEE_SEQUENCE"
}

resource "snowflake_sequence_grant" "employee_sequence_grant" {
  database_name = snowflake_database.employee_db.name
  schema_name   = snowflake_schema.employee_schema.name
  sequence_name = snowflake_sequence.employee_sequence.name
  privilege = "SELECT"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_table" "employee_table" {
  database            = snowflake_database.employee_db.name
  schema              = snowflake_schema.employee_schema.name
  name                = "EMPLOYEE"
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

resource "snowflake_table_grant" "employee_table_grant" {
  database_name = snowflake_database.employee_db.name
  schema_name   = snowflake_schema.employee_schema.name
  table_name    = snowflake_table.employee_table.name
  privilege = "USAGE"
  roles     = ["ACCOUNTADMIN"]
}






