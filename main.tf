terraform {
  required_providers {
    
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "~> 0.65.0"
    }
  }

  cloud {
    organization = "Cognizant-kolkata"
    workspaces {
      name = "terraforming-snowflake"
    }
  }

}

resource "snowflake_warehouse" "warehouse" {
  name = "CVS_WH"
  warehouse_size = "LARGE"
  auto_suspend = 600
}

resource "snowflake_database" "db" {
  name = "CVS_DB"
  comment = "test CVS_DB"
  data_retention_time_in_days = 3
}

resource "snowflake_external_table" "external_table_1" {
  name        = "CVS_DB_TABLE"
  comment     = "External table-CVS_DB_TABLE"
  database    = "db"
  location    = "externalStage"
  refresh_on_create = "true"
  schema      = "schema"
  file_format = "TYPE = CSV FIELD_DELIMITER = '|'"
  column { 
    name = "employee_id"
    type = "int"
    as   = "NUMBER"
  } 
  column { 
    name = "employee_dept"
    type = "text"
    as   = "VARCHAR"
  } 
}

resource "snowflake_database" "db_post" {
  name = "CVS_DB_POST"
  comment = "test CVS_DB"
  data_retention_time_in_days = 3
}

resource "snowflake_database" "db_test" {
  name = "CVS_DB_TEST"
  comment = "test CVS_DB"
  data_retention_time_in_days = 3
}