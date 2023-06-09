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

resource "snowflake_warehouse_grant" "CVS_WH_grant" {
  warehouse_name = "CVS_WH"
  privilege      = "ALL PRIVILEGES"
  roles = ["ACCOUNTADMIN"]
} 








