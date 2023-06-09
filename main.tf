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
  roles = ["ACCOUNTADMIN","ORGADMIN"]
} 

resource "snowflake_database" "employee_db" {
  name = "CVS_EMPLOYEE_DATA"
}

resource "snowflake_database_grant" "employee_db_grant" {
  database_name = snowflake_database.employee_db.name
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_schema" "employee_schema" {
  database            = snowflake_database.employee_db.name
  name                = "CVS_EMPLOYEE_SCHEMA"
}

resource "snowflake_schema_grant" "employee_schema_grant" {
  database_name = snowflake_database.employee_db.name
  schema_name   = snowflake_schema.employee_schema.name
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_sequence" "employee_sequence" {
  database =  snowflake_database.employee_db.name
  schema   = snowflake_schema.employee_schema.name
  name     = "CVS_EMPLOYEE_SEQUENCE"
}

resource "snowflake_sequence_grant" "employee_sequence_grant" {
  database_name = snowflake_database.employee_db.name
  schema_name   = snowflake_schema.employee_schema.name
  sequence_name = snowflake_sequence.employee_sequence.name
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_database" "billing_db" {
  name = "CVS_PROJ_BILLING_DATA"
}

resource "snowflake_database_grant" "billing_db_grant" {
  database_name = snowflake_database.billing_db.name
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_schema" "customer_schema" {
  database            = snowflake_database.billing_db.name
  name                = "CVS_CUSTOMER_SCHEMA"
}

resource "snowflake_schema_grant" "customer_schema_grant" {
  database_name = snowflake_database.billing_db.name
  schema_name   = snowflake_schema.customer_schema.name
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_sequence" "customer_sequence" {
  database = snowflake_database.billing_db.name
  schema   = snowflake_schema.customer_schema.name
  name     = "CVS_CUSTOMER_SEQUENCE"
}

resource "snowflake_sequence_grant" "customer_sequence_grant" {
  database_name = snowflake_database.billing_db.name
  schema_name   = snowflake_schema.customer_schema.name
  sequence_name = snowflake_sequence.customer_sequence.name
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN","ORGADMIN"]
}

resource "snowflake_table" "employee_table" {
  database            = snowflake_database.employee_db.name
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

resource "snowflake_table_grant" "employee_table_grant" {
  database_name = "CVS_EMPLOYEE_DATA"
  schema_name   = "CVS_EMPLOYEE_SCHEMA"
  table_name    = "EMPLOYEE"
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN"]
}


resource "snowflake_table" "customer_table" {
  database            = snowflake_database.billing_db.name
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
  schema_name   = "CVS_CUSTOMER_SCHEMA"
  table_name    = "CUSTOMER_BILLING"
  privilege = "ALL PRIVILEGES"
  roles     = ["ACCOUNTADMIN"]
}






