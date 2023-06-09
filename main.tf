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

resource "snowflake_database" "employee_db" {
  name                        = "CVS_EMPLOYEE_DATA"
}

resource "snowflake_database" "project_db" {
  name                        = "CVS_PROJECT_DATA"
}

resource "snowflake_database" "billing_db" {
  name                        = "CVS_PROJ_BILLING_DATA"
}

