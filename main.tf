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
  data_retention_time_in_days = 1
}

resource "snowflake_schema" "schema" {
  database            = snowflake_database.db.name
  name                = "CVS_DB_TABLE_schema"
}

resource "snowflake_sequence" "sequence" {
  database = snowflake_schema.schema.database
  schema   = snowflake_schema.schema.name
  name     = "CVS_DB_TABLE_sequence"
}

resource "snowflake_table" "cvs_db_table" {
  database            = snowflake_schema.schema.database
  schema              = snowflake_schema.schema.name
  name                = "CVS_DB_TABLE"
  comment             = "CVS_DB_TABLE"
  cluster_by          = ["employee_dept"]
  change_tracking     = false

  column {
    name     = "employee_id"
    type     = "int"
    nullable = false
  }

  column {
    name     = "employee_name"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "employee_dept"
    type     = "varchar"
    nullable = false
  }

  column {
    name = "employee_ DOJ"
    type = "TIMESTAMP_NTZ(9)"
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