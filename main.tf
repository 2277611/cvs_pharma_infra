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
      name = "cvs_pharma_infra"
    }
  }

}

resource "snowflake_warehouse" "warehouse" {
  name           = "CVS_WH"
  warehouse_size = "LARGE"
  auto_suspend   = 600
}

resource "snowflake_database" "employee" {
  name                        = "CVS_EMPLOYEE_DATA"
}

resource "snowflake_database" "project" {
  name                        = "CVS_PROJECT_DATA"
}

resource "snowflake_database" "billing" {
  name                        = "CVS_PROJ_BILLING_DATA"
}

resource "snowflake_schema" "schema" {
  database            = "CVS_EMPLOYEE_DATA"
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
