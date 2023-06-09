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
  name                        = "CVS_EMPLOYEE_DATA"
}

resource "snowflake_database_grant" "employee_db_grant" {
  database_name = "CVS_EMPLOYEE_DATA"
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN"]
}

resource "snowflake_sequence" "employee_sequence" {
  database =  snowflake_database.employee_db.name
  schema   = snowflake_schema.employee_schema.name
  name     = "CVS_EMPLOYEE_SEQUENCE"
}



