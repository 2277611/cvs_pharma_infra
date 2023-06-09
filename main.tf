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

resource "snowflake_schema" "customer_schema" {
  database            = "CVS_PROJ_BILLING_DATA"
  name                = "CVS_DB_SCHEMA_CUST"
}

resource "snowflake_sequence" "sequence" {
  database = snowflake_schema.schema.database
  schema   = snowflake_schema.schema.name
  name     = "CVS_DB_SEQUENCE"
}
resource "snowflake_sequence" "customer_sequence" {
  database = snowflake_schema.customer_schema.database
  schema   = snowflake_schema.customer_schema.name
  name     = "CVS_DB_SEQUENCE_CUST"
} 

resource "snowflake_table" "table" {
  database            = snowflake_schema.schema.database
  schema              = snowflake_schema.schema.name
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

resource "snowflake_table_grant" "grant" {
  database_name = "CVS_EMPLOYEE_DATA"
  schema_name   = "CVS_DB_SCHEMA"
  table_name    = "EMPLOYEE"
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN"]
}


resource "snowflake_table" "customer" {
  database            = snowflake_schema.customer_schema.database
  schema              = snowflake_schema.customer_schema.name
  name                = "CUSTOMER_BILLING"
  column {
    name     = "CustID"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "Company"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "Address"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "City"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "State"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "Zip"
    type     = "varchar"
    nullable = false
  }

   column {
    name     = "Country"
    type     = "varchar"
    nullable = false
  }

  column {
    name     = "Phone"
    type     = "varchar"
    nullable = false
  }

}

resource "snowflake_table_grant" "grant_cust" {
  database_name = "CVS_PROJ_BILLING_DATA"
  schema_name   = "CVS_DB_SCHEMA_CUST"
  table_name    = "CUSTOMER_BILLING"
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN"]
}