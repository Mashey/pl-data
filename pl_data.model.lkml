connection: "plpc"
case_sensitive: no

include: "/views/*.lkml"

explore: ticket_items {
  from: ticket_items
  group_label: " Treez Data_SellTreez"

  join: dim_tickets {
    view_label: "Tickets"
    type: inner
    relationship: many_to_one
    sql_on: ${dim_tickets.ticket_id} = ${ticket_items.ticket_id} ;;
  }

 join: dim_customers {
    view_label: "Customers"
    type: inner
    relationship: many_to_one
    sql_on: ${dim_tickets.customer_id} = ${dim_customers.customer_id};;
  }

  join: customer_addresses {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customer_addresses.customer_id} = ${dim_customers.customer_id};;
  }

  join: dim_products{
    view_label: "Products"
    type: inner
    relationship: many_to_one
    sql_on: ${ticket_items.product_id} = ${dim_products.product_id};;
  }

}

explore: customers {
  from: dim_customers
  group_label: " Treez Data_SellTreez"

  join: customer_addresses {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customer_addresses.customer_id} = ${customers.customer_id};;
  }

  join: int_brand_ranking {
    view_label: "Brand_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_brand_ranking.customer_id} = ${customers.customer_id} ;;
  }

  join: int_product_ranking {
    view_label: "Product_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_product_ranking.customer_id} = ${customers.customer_id} ;;
  }

  join: int_product_type_ranking {
    view_label: "Product_Type_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_product_type_ranking.customer_id} = ${customers.customer_id} ;;
  }

  join: int_sales_channel_ranking {
    view_label: "Sales_Channel_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_sales_channel_ranking.customer_id} = ${customers.customer_id} ;;
  }

}

explore: dim_tickets {
  group_label: " Treez Data_SellTreez"
  view_label: "Tickets"
  label: "Tickets"

  join: ticket_item_discounts {
    view_label: "Discounts"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ticket_item_discounts.ticket_id} = ${dim_tickets.ticket_id} ;;
  }

  join: dim_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_customers.customer_id} = ${dim_tickets.customer_id} ;;
  }
  }
