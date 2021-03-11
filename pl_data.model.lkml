connection: "plpc"
case_sensitive: no

include: "/views/*.lkml"

explore: order_items {
  from: ticket_items

  join: tickets {
    type: inner
    relationship: many_to_one
    sql_on: ${tickets.ticket_id} = ${order_items.ticket_id} ;;
  }

  join: customers {
    type: inner
    relationship: many_to_one
    sql_on: ${tickets.customer_id} = ${customers.id} ;;
  }

  join: products {
    type: inner
    relationship: many_to_one
    sql_on: ${order_items.product_id} = ${products.product_id};;
  }

  join: payments {
    type: left_outer
    relationship: one_to_many
    sql_on: ${payments.ticket_id} = ${tickets.ticket_id} ;;
  }

  join: ticket_item_taxes {
    type: left_outer
    relationship: one_to_many
    sql_on: ${ticket_item_taxes.ticket_id} = ${order_items.ticket_id} AND ${ticket_item_taxes.product_id} = ${order_items.product_id} ;;
  }

  join: ticket_item_discounts {
    type: left_outer
    relationship: one_to_many
    sql_on: ${ticket_item_discounts.ticket_id} = ${order_items.ticket_id} AND ${ticket_item_discounts.product_id} = ${order_items.product_id} ;;
  }

  join: customer_addresses {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customer_addresses.customer_id} = ${customers.id} ;;
  }

  join: int_brand_ranking {
    view_label: "Brand_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_brand_ranking.customer_id} = ${customers.id} ;;
  }

  join: int_product_ranking {
    view_label: "Product_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_product_ranking.customer_id} = ${customers.id} ;;
  }

  join: int_product_type_ranking {
    view_label: "Product_Type_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_product_type_ranking.customer_id} = ${customers.id} ;;
  }

  join: int_sales_channel_ranking {
    view_label: "Sales_Channel_Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${int_sales_channel_ranking.customer_id} = ${customers.id} ;;
  }

  join: dim_customers {
    view_label: "Customers_Dim_LTV"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_customers.customer_id} = ${tickets.customer_id} ;;
  }
}
