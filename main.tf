terraform {
  required_providers {

    snowflake = {
      source  = "Snowflake-Labs/snowflake"
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
  name           = "CVS_WH"
  warehouse_size = "LARGE"
  auto_suspend   = 600
}

resource "snowflake_database" "db" {
  name                        = "CVS_DB"
  comment                     = "test CVS_DB"
}

resource "snowflake_schema" "schema" {
  database            = "snowflake_database.db.name"
  name                = "CVS_DB_SCHEMA"
}

resource "snowflake_sequence" "sequence" {
  database = snowflake_schema.schema.database
  schema   = snowflake_schema.schema.name
  name     = "CVS_DB_SEQUENCE"
}

resource "snowflake_table" "table" {
  database            = snowflake_schema.schema.database
  schema              = snowflake_schema.schema.name
  name                = "EMPLOYEE"
  comment             = "Employee Table"
  cluster_by          = ["employee_dept"]
  change_tracking     = false

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

  column {
    name = "employee_ DOJ"
    type = "TIMESTAMP_NTZ(9)"
  }
}

resource "snowflake_database" "db_post" {
  name                        = "CVS_DB_POST"
  comment                     = "test CVS_DB"
  data_retention_time_in_days = 3
}

resource "snowflake_database" "db_test" {
  name                        = "CVS_DB_TEST"
  comment                     = "test CVS_DB"
  data_retention_time_in_days = 3
}