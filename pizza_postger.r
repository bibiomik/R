## Restaurant pizza SQL on PostgreSQL

## connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

## create connection
con <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "hiiqbisj",
  user = "hiiqbisj",
  password = "VMpezkCNrPFahgb49qjCnuY7XDoPK7GR",
  port = 5432
)

## db list table
dbListTables(con)

## restaurant pizza SQL
## create 3-5 dataframes => write table into server

##create customer dataframe
customers <- tribble(
  ~customer_id, ~customer_name, ~phone,
  1, "Bob Johnson", "0812-123-4567",
  2, "Alice Brown", "0812-456-7890",
  3, "Tom Smith", "0812-789-1234",
  4, "Jane Doe", "0813-975-6542",
  5, "John Wick", "0911-659-6412"
)

menus <- tribble(
  ~menu_id, ~menu_name, ~price,
  1, "Sauage Hawaiian", 13.60,
  2, "BBQ Chicken", 13.00,
  3, "Extreme Cheese", 10.80,
  4, "Pepperoni", 14.30,
  5, "Cheeseburger Beef", 17.50
)

orders <- tribble(
  ~order_id, ~customer_id, ~menu_id, ~order_date,
  1, 1, 1, "2023-11-06",
  2, 1, 3, "2023-11-06",
  3, 1, 5, "2023-11-06",
  4, 5, 4, "2023-11-08",
  5, 5, 3, "2023-11-08",
  6, 5, 4, "2023-11-08",
  7, 5, 5, "2023-11-08"
)

dbWriteTable(con, "customers", customers)
dbWriteTable(con, "menus", menus)
dbWriteTable(con, "orders", orders)


dbListTables(con)

menus <- dbGetQuery(con, "select * from menus")

##colse connection
dbDisconnect(con)
