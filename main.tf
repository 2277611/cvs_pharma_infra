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
  data_retention_time_in_days = 3
}

resource "snowflake_database" "db" {
  name = "CVS_DB_POST"
  comment = "test CVS_DB"
  data_retention_time_in_days = 3
}