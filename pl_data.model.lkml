connection: "plpc"
case_sensitive: no

include: "/**/*.view.lkml"

explore: core_ticket_items {
  #hidden: yes
  from: core_ticket_items
  group_label: " Treez Data_SellTreez"

  join: dim_tickets {
    view_label: "Tickets"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_tickets.ticket_id} = ${core_ticket_items.ticket_id} ;;
  }

# explore: dim_tickets {
#   #hidden: yes
#   from: dim_tickets
#   group_label: " Treez Data_SellTreez"

#   join: ticket_items {
#     view_label: "Tickets"
#     type: inner
#     relationship: one_to_many
#     sql_on: ${dim_tickets.ticket_id} = ${ticket_items.ticket_id} ;;
#   }

 join: dim_customers {
    view_label: "Customers"
    type: left_outer
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
    sql_on: ${core_ticket_items.ticket_id} = ${dim_products.product_id};;
  }

}

explore: customers {
  hidden: yes
  from: dim_customers
  group_label: " Treez Data_SellTreez"

  join: dim_tickets {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customers.customer_id} = ${dim_tickets.customer_id} ;;
  }

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


  join: core_ticket_items {
    view_label: "Ticket Items"
    type: inner
    relationship: one_to_many
    sql_on: ${dim_tickets.ticket_id} = ${core_ticket_items.ticket_id} ;;
  }

  join: dim_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_customers.customer_id} = ${dim_tickets.customer_id} ;;
  }

  join: customer_addresses {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customer_addresses.customer_id} = ${dim_customers.customer_id};;
  }

}

explore: core_domo_ticket_items {
  group_label: " Treez Data - DOMO NEW"
  view_label: "Order Items"
  label: "Order Items"

  join: dim_domo_current_inventory {
    view_label: "dim_Current Inventory"
    type: left_outer
    relationship: many_to_one
    sql_on: ${core_domo_ticket_items.product_id} = ${dim_domo_current_inventory.product_id} ;;
  }

  join: core_domo_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${core_domo_customers.customer_uuid} = ${core_domo_ticket_items.customer_uuid} ;;
  }

  join: core_domo_discount {
    view_label: "Discounts"
    type: left_outer
    relationship: one_to_many
    sql_on: ${core_domo_discount.ticketlineid} = ${core_domo_ticket_items.ticketlineid} ;;
  }

  join: core_domo_customer_location {
    view_label: "Customer Location"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customer_location.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: core_domo_customer_lifetime_data {
    view_label: "Customer Lifetime Data"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customers.customer_uuid} = ${core_domo_customer_lifetime_data.customer_uuid} ;;
  }

  join: domo_brand_ranking {
    view_label: "Brand Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_brand_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_product_ranking {
    view_label: "Product Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_product_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_product_type_ranking {
    view_label: "Product Type Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_product_type_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_subtype_ranking {
    view_label: "Product Subtype Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${core_domo_customers.customer_uuid} = ${domo_subtype_ranking.customer_uuid} ;;
  }

  join: domo_sales_channel_ranking {
    view_label: "Sales Channel Ranking"
    type: inner
    relationship: one_to_many
    sql_on: ${domo_sales_channel_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: ticket_rank_by_sales {
    view_label: "Ticket Rank By Sales"
    type: left_outer
    relationship: many_to_one
    sql_on: ${ticket_rank_by_sales.ticketid} = ${core_domo_ticket_items.ticketid} AND ${ticket_rank_by_sales.customer_uuid} = ${core_domo_ticket_items.customer_uuid} ;;
  }

  join: domo_product_ranking_by_register {
    view_label: "Product Rank By Register"
    type: inner
    relationship: many_to_one
    sql_on: ${domo_product_ranking_by_register.register} = ${core_domo_ticket_items.register} AND ${domo_product_ranking_by_register.product_id} = ${core_domo_ticket_items.product_id} ;;
  }

  join: domo_classification_ranking {
    view_label: "Classification Ranking"
    type: left_outer
    relationship: many_to_one
    sql_on: ${domo_classification_ranking.customer_uuid} = ${core_domo_ticket_items.customer_uuid} AND ${domo_classification_ranking.classification} = ${core_domo_ticket_items.classification}  ;;
  }

  join: derived_user_cohort {
    view_label: "XX - User Cohort Filters"
    type: inner
    relationship: many_to_one
    sql_on: ${core_domo_ticket_items.customer_uuid} = ${derived_user_cohort.customer_uuid};;
  }

  join: Stiiizy_test {
    view_label: "BayLifeFav_test"
    type: inner
    relationship: many_to_one
    sql_on: ${core_domo_ticket_items.customer_uuid} = ${Stiiizy_test.customer_uuid} ;;
  }

}

explore: core_domo_customers {
  group_label: " Treez Data - DOMO NEW"
  view_label: "Customers"
  label: "Customers"

  join: core_domo_customer_lifetime_data {
    view_label: "Customer Lifetime Data"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customer_lifetime_data.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: core_domo_customer_location {
    view_label: "Customer Location"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customer_location.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_brand_ranking {
    view_label: "Brand Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_brand_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_product_ranking {
    view_label: "Product Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_product_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_product_type_ranking {
    view_label: "Product Type Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_product_type_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: domo_sales_channel_ranking {
    view_label: "Sales Channel Ranking"
    type: left_outer
    relationship: one_to_many
    sql_on: ${domo_sales_channel_ranking.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }
}

explore: agg_domo_tickets {
  hidden: yes
  group_label: " Treez Data - DOMO NEW"
  view_label: "Orders"
  label: "Orders"

  join: core_domo_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${agg_domo_tickets.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

}

explore: core_domo_inventory {
  label: "Inventory"
    view_label: "Inventory"
    group_label: " Treez Data - DOMO NEW"

  join: dim_domo_inventory {
    view_label: "dim_Inventory"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_domo_inventory.product_id} = ${core_domo_inventory.product_id} ;;
  }

  join: dim_domo_current_inventory {
    view_label: "dim_Current Inventory"
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_domo_current_inventory.product_id} = ${core_domo_inventory.product_id} ;;
  }

  join: core_reorder_product_depletion {
    view_label: "Reorder"
    type: left_outer
    relationship: many_to_one
    sql_on: ${core_reorder_product_depletion.product_id} = ${core_domo_inventory.product_id} ;;
  }

  join: core_domo_ticket_items {
    view_label: "Order Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_domo_inventory.product_id} = ${core_domo_ticket_items.product_id} ;;
  }

  join: core_domo_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${core_domo_customers.customer_uuid} = ${core_domo_ticket_items.customer_uuid} ;;
  }

}


explore: core_reorder_product_depletion {
  label: "Inventory Reorder"
  view_label: "Inventory Reorder"
  group_label: " Treez Data - DOMO NEW"

  join: dim_domo_current_inventory {
    view_label: "dim_Current Inventory"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_reorder_product_depletion.product_id} = ${dim_domo_current_inventory.product_id} ;;
  }

  join: core_domo_ticket_items {
    view_label: "Order Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${core_reorder_product_depletion.product_id} = ${core_domo_ticket_items.product_id} ;;
  }

  join: dim_domo_inventory {
    view_label: "dim_Inventory"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_reorder_product_depletion.product_id} = ${dim_domo_inventory.product_id} ;;
  }
}


explore: order_purchase_affinity {
 label: "Item Affinity"
  view_label: "Item Affinity"
  group_label: " Treez Data - DOMO NEW"

  always_filter: {
    filters: {
      field: affinity_timeframe
      value: "last 90 days"
    }
    filters: {
      field: order_items_base.product_level
      #### TO DO: Replace with your most used hierarchy level (defined in the affinity_analysis view)
      value: "BRAND"
    }
  }

  join: order_items_base {}

  join: total_orders {
    type: cross
    relationship: many_to_one
  }

  }


explore: core_ga_alltraffic2 {
  label: "ga_All Traffic"
  view_label: "ga_All Traffic"
  group_label: "Google Analytics"
}


explore: brand_exclusivity {
    label: "Brand Exclusivity"
    view_label: "Brand Exclusivity"
    group_label: " Treez Data - DOMO NEW"

  join: core_domo_customers {
    view_label: "Customers"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customers.customer_uuid} = ${brand_exclusivity.customer_uuid} ;;
  }

  join: core_domo_customer_location {
    view_label: "Customer Location"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customer_location.customer_uuid} = ${brand_exclusivity.customer_uuid} ;;
  }

  join: core_domo_customer_lifetime_data {
    view_label: "Customer Lifetime Data"
    type: left_outer
    relationship: one_to_one
    sql_on: ${core_domo_customer_lifetime_data.customer_uuid} = ${brand_exclusivity.customer_uuid} ;;
  }

  join: core_domo_ticket_items {
    view_label: "Order Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${core_domo_ticket_items.customer_uuid} = ${brand_exclusivity.customer_uuid} ;;
  }
  }

  explore: core_domo_discount {
    label: "Discounts"
    view_label: "Discounts"
    group_label: " Treez Data - DOMO NEW"

  join: core_domo_customers {
    view_label: "Customers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${core_domo_discount.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
  }

  join: core_domo_customer_lifetime_data {
    view_label: "Customer Lifetime Data"
    type: left_outer
    relationship: many_to_one
    sql_on: ${core_domo_discount.customer_uuid} = ${core_domo_customer_lifetime_data.customer_uuid};;
  }
  }

  explore: core_domo_inventory_historical {
    label: "Historical Inventory"
    group_label: " Treez Data - DOMO NEW"
    view_label: "Historical Inventory"

  join: core_domo_ticket_items {
    view_label: "Order Items"
    type: left_outer
    relationship: one_to_many
    sql_on: ${core_domo_inventory_historical.product_id} = ${core_domo_ticket_items.product_id} AND CAST(${core_domo_inventory_historical.inventory_valuation_date} as date) = CAST(${core_domo_ticket_items.date_closed_date} as date);;
  }
  }

  explore: core_domo_invoices {
    label: "Invoices - Inventory"
    group_label: " Treez Data - DOMO NEW"
    view_label: "Invoices - Inventory"
  }


  explore: latest_mc_campaigns {
    label: "Campaigns"
    view_label: "Campaigns"

    join: latest_mc_sent_to {
      view_label: "Sent To"
      type: left_outer
      relationship: one_to_many
      sql_on: ${latest_mc_campaigns.id} = ${latest_mc_sent_to.campaign_id} ;;
    }

    join: latest_mc_email_activity {
      view_label: "Email Activity"
      type: left_outer
      relationship: one_to_many
      sql_on: ${latest_mc_sent_to.campaign_id} = ${latest_mc_sent_to.campaign_id} and
      ${latest_mc_sent_to.email_id} = ${latest_mc_email_activity.email_id} and
      ${latest_mc_sent_to.list_id} = ${latest_mc_email_activity.list_id};;
    }

    join: core_domo_customers {
      view_label: "Customers"
      type: left_outer
      relationship: many_to_one
      sql_on: ${core_domo_customers.email} = coalesce(${latest_mc_sent_to.email_address}, ${latest_mc_email_activity.email_address})

      -- ${latest_mc_sent_to.email_address} = ${core_domo_customers.email}
      -- OR ${latest_mc_email_activity.email_address} = ${core_domo_customers.email}
      ;;
    }

    join: core_domo_ticket_items {
      view_label: "Ticket Items"
      type: left_outer
      relationship: one_to_many
      sql_on: ${core_domo_ticket_items.customer_uuid} = ${core_domo_customers.customer_uuid} and
        (${core_domo_ticket_items.date_closed_date} > ${latest_mc_sent_to.first_open_date} and
        ${core_domo_ticket_items.date_closed_date} <= date_add(${latest_mc_sent_to.first_open_date}, interval 14 day)) ;;
    }

    join: core_domo_customer_location {
      view_label: "Customer Location"
      type: left_outer
      relationship: one_to_one
      sql_on: ${core_domo_customer_location.customer_uuid} = ${core_domo_customers.customer_uuid} ;;
    }
  }
