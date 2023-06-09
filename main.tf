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
}

resource "snowflake_schema" "employee_schema" {
  database = "CVS_EMPLOYEE_DATA"
  name = "CVS_EMPLOYEE_SCHEMA"
}

resource "snowflake_sequence" "employee_sequence" {
  database = "CVS_EMPLOYEE_DATA"
  schema = "CVS_EMPLOYEE_SCHEMA"
  name = "CVS_EMPLOYEE_SEQUENCE"
}







