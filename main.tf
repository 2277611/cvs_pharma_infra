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

resource "snowflake_database" "billing_db" {
  name = "CVS_PROJ_BILLING_DATA"
}

resource "snowflake_schema" "employee_schema" {
  database            = snowflake_database.employee_db.name
  name                = "CVS_EMPLOYEE_SCHEMA"
}

resource "snowflake_schema" "customer_schema" {
  database            = snowflake_database.billing_db.name
  name                = "CVS_CUSTOMER_SCHEMA"
}

resource "snowflake_sequence" "employee_sequence" {
  database =  snowflake_database.employee_db.name
  schema   = snowflake_schema.employee_schema.name
  name     = "CVS_EMPLOYEE_SEQUENCE"
}
resource "snowflake_sequence" "customer_sequence" {
  database = snowflake_database.billing_db.name
  schema   = snowflake_schema.customer_schema.name
  name     = "CVS_CUSTOMER_SEQUENCE"
}







