view: core_reorder_product_depletion {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_reorder_product_depletion`
    ;;

  dimension: days_of_sales_prior30 {
    type: number
    sql: ${TABLE}.days_of_sales_prior30 ;;
  }

  dimension: days_of_sales_prior7 {
    type: number
    sql: ${TABLE}.days_of_sales_prior7 ;;
  }

  dimension: product_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: remaining_units {
    type: number
    sql: ${TABLE}.remaining_units ;;
  }

  dimension: units_sold_prior_30 {
    type: number
    sql: ${TABLE}.units_sold_prior_30 ;;
  }

  dimension: units_sold_prior_7 {
    type: number
    sql: ${TABLE}.units_sold_prior_7 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_remaining_units {
    type: sum
    value_format: "#,##0.00"
    sql: ${remaining_units} ;;
    drill_fields: [
      dim_domo_current_inventory.product_id,
      dim_domo_current_inventory.productname,
      dim_domo_current_inventory.productbrand,
      dim_domo_current_inventory.producttype,
      dim_domo_current_inventory.shelf,
      dim_domo_current_inventory.total_units,
      dim_domo_current_inventory.total_cost,
      dim_domo_current_inventory.average_days_aged_weighted,
      units_sold_daily_depletion_7,
      days_remaining_d7,
      units_sold_daily_depletion_30,
      days_remaining_d30
    ]
  }

  measure: sum_units_sold_prior30 {
    type: sum
    value_format: "#,##0.00"
    sql: ${units_sold_prior_30} ;;
    drill_fields: [
      core_domo_ticket_items.total_units_sold_gross,
      core_domo_ticket_items.total_units_returned,
      core_domo_ticket_items.total_units_sold_net,
      core_domo_ticket_items.total_net_sales,
      core_domo_ticket_items.discount_rate,
      core_domo_ticket_items.gross_margin
    ]
  }

  measure: sum_units_sold_prior7 {
    type: sum
    value_format: "#,##0.00"
    sql: ${units_sold_prior_7} ;;
    drill_fields: [
      core_domo_ticket_items.units_sold_net,
      core_domo_ticket_items.net_sales,
      core_domo_ticket_items.discount_rate,
      core_domo_ticket_items.gross_margin
    ]
  }

  measure: units_sold_daily_depletion_7 {
    type: sum
    label: "Daily Depletion Rate_7"
    description: "Daily Depletion Rate based on units sold prior 7 days"
    value_format: "#,##0.00"
    sql: COALESCE(${units_sold_prior_7} / nullif(${days_of_sales_prior7},0),0) ;;
  }

  measure: units_sold_daily_depletion_30 {
    type: sum
    label: "Daily Depletion Rate_30"
    description: "Daily Depletion Rate based on units sold prior 30 days"
    value_format: "#,##0.00"
    sql: COALESCE(${units_sold_prior_30} / nullif(${days_of_sales_prior30},0),0) ;;
  }

  measure: days_remaining_d7 {
    type: number
    sql: floor(coalesce(${sum_remaining_units} / nullif(${units_sold_daily_depletion_7},0),0)) ;;
  }

  measure: days_remaining_d30 {
    type: number
    sql: floor(coalesce(${sum_remaining_units} / nullif(${units_sold_daily_depletion_30},0),0)) ;;
  }


}
