terraform {
  required_providers {

    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.65.0"
    }
  }

  cloud {
    organization = "CTS-ITPKDC-C3-F4-ODC3"
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

