terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.59"
    }
  }
}

provider "snowflake" {
  account  = "ACOUNTADMIN" 
  username = "SNOWFLAKECOGNIZANT" 
  password = "Cts@271219921"
  region    = "gcp_europe_west2" 
}

resource "snowflake_database" "db" {
  name     = "SNOWFLAKE_SAMPLE_DATA"
}

resource "snowflake_warehouse" "warehouse" {
  name           = "SNOWFLAKE_SAMPLE_DATA"
  warehouse_size = "LARGE"

  auto_suspend = 60
}