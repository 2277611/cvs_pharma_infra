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


resource "snowflake_database" "employee_db" {
  name = "CVS_EMPLOYEE_DATA"
  comment = "Created by terraform"
  data_retention_time_in_days = 7
  
}


resource "snowflake_schema" "employee_schema" {
  database            = "CVS_EMPLOYEE_DATA"
  name                = "CVS_EMPLOYEE_SCHEMA"
  data_retention_days = 7
}


resource "snowflake_sequence" "employee_sequence" {
  database =  snowflake_schema.employee_schema.database
  schema   = snowflake_schema.employee_schema.name
  name     = "CVS_EMPLOYEE_SEQUENCE"
}


resource "snowflake_table" "employee_table" {
  database            = snowflake_schema.employee_schema.database
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








