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

  dimension: days_of_sales_prior7to14 {
    type: number
    sql: ${TABLE}.days_of_sales_prior7to14 ;;
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

  dimension: sales_prior_7 {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.sales_prior7 ;;
  }

  dimension: sales_prior_7to14 {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.sales_prior7to14 ;;
  }

  dimension: sales_prior_30{
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.sales_prior30 ;;
  }

  dimension: gross_profit_prior7 {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.gross_profit_prior7 ;;
  }

  dimension: gross_profit_prior7to14 {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.gross_profit_prior7to14 ;;
  }

  dimension: gross_profit_prior30 {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.gross_profit_prior30 ;;
  }

  dimension: units_sold_prior_30 {
    type: number
    sql: ${TABLE}.units_sold_prior_30 ;;
  }

  dimension: units_sold_prior_7 {
    type: number
    sql: ${TABLE}.units_sold_prior_7 ;;
  }

  dimension: units_sold_prior_7to14 {
    type: number
    sql: ${TABLE}.units_sold_prior_7to14 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: sum_remaining_units {
    label: "Remaining Units"
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
      units_sold_daily_depletion_30,
      days_remaining_d7,
      days_remaining_d30
    ]
  }

  measure: sum_units_sold_prior30 {
    label: "Units Sold Last 30 Days"
    group_label: "Last 30 Days"
    type: sum
    value_format: "#,##0.00"
    sql: ${units_sold_prior_30} ;;
  }

  measure: sum_units_sold_prior7 {
    label: "Units Sold Last 7 Days"
    group_label: "Last 7 Days"
    type: sum
    value_format: "#,##0.00"
    sql: ${units_sold_prior_7} ;;
  }

  measure: sum_units_sold_prior7to14 {
    label: "Units Sold Week Prior"
    group_label: "Week Prior"
    type: sum
    value_format: "#,##0.00"
    sql: ${units_sold_prior_7to14} ;;
  }

  measure: units_sold_daily_depletion_7 {
    group_label: "Last 7 Days"
    type: sum
    label: "Units Sold Daily Depletion Last 7 Days"
    description: "Daily Depletion Rate based on units sold prior 7 days"
    value_format: "#,##0.00"
    sql: COALESCE(${units_sold_prior_7}/ 7,0) ;;
  }

  measure: units_sold_daily_depletion_30 {
    label: "Units Sold Daily Depletion Last 30 Days"
    group_label: "Last 30 Days"
    type: sum
    description: "Daily Depletion Rate based on units sold prior 30 days"
    value_format: "#,##0.00"
    sql: COALESCE(${units_sold_prior_30} / 30,0) ;;
  }

  measure: units_sold_daily_depletion_7to14 {
    label: "Units Sold Daily Depletion Week Prior"
    group_label: "Week Prior"
    type: sum
    description: "Daily Depletion Rate based on units sold prior 7-14 days"
    value_format: "#,##0.00"
    sql: COALESCE(${units_sold_prior_7to14} / 7,0) ;;
  }

  measure: days_remaining_d7 {
    label: "Days Remaining Last 7 Days"
    group_label: "Last 7 Days"
    type: number
    sql: floor(coalesce(${sum_remaining_units} / nullif(${units_sold_daily_depletion_7},0),0)) ;;
  }

  measure: days_remaining_d30 {
    label: "Days Remaining Last 30 Days"
    group_label: "Last 30 Days"
    type: number
    sql: floor(coalesce(${sum_remaining_units} / nullif(${units_sold_daily_depletion_30},0),0)) ;;
  }

  measure: days_remaining_d7to14 {
    label: "Days Remaining Week Prior"
    group_label: "Week Prior"
    type: number
    sql: floor(coalesce(${sum_remaining_units} / nullif(${units_sold_daily_depletion_7to14},0),0)) ;;
  }

  measure: weeks_remaining_d7to14 {
    label: "Weeks Remaining Week Prior"
    group_label: "Week Prior"
    type: number
    value_format: "0.0"
    sql: coalesce(${days_remaining_d7to14} / 7,0) ;;
  }

  measure: weeks_remaining_d7 {
    label: "Weeks Remaining Last 7 Days"
    group_label: "Last 7 Days"
    type: number
    value_format: "0.0"
    sql: coalesce(${days_remaining_d7} / 7,0) ;;
  }

  measure: weeks_remaining_d30{
    label: "Weeks Remaining Last 30 Days"
    group_label: "Last 30 Days"
    type: number
    value_format: "0.0"
    sql: coalesce(${days_remaining_d30} / 7,0) ;;
  }

  measure: total_gross_profit_prior7 {
    label: "$ Gross Profit Last 7 Days"
    group_label: "Last 7 Days"
    type: sum
    value_format: "$#,##0.00"
    sql: ${gross_profit_prior7} ;;
  }

  measure: total_gross_profit_prior7to14 {
    label: "$ Gross Profit Week Prior"
    group_label: "Week Prior"
    type: sum
    value_format: "$#,##0.00"
    sql: ${gross_profit_prior7to14} ;;
  }

  measure: total_gross_profit_prior30 {
    label: "$ Gross Profit Last 30 Days"
    group_label: "Last 30 Days"
    type: sum
    value_format: "$#,##0.00"
    sql: ${gross_profit_prior30} ;;
  }

  measure: total_sales_d30 {
    label: "$ Sold Last 30 Days"
    group_label: "Last 30 Days"
    type: sum
    value_format: "$#,##0.00"
    sql: ${sales_prior_30} ;;
  }

  measure: total_sales_d7to14 {
    label: "$ Sold Week Prior"
    group_label: "Week Prior"
    type: sum
    value_format: "$#,##0.00"
    sql: ${sales_prior_7to14} ;;
    drill_fields: [core_domo_ticket_items.productname, core_domo_ticket_items.productbrand, core_domo_ticket_items.product_type, sum_units_sold_prior7to14]
  }

  measure: total_sales_d7 {
    label: "$ Sold Last 7 Days"
    group_label: "Last 7 Days"
    type: sum
    value_format: "$#,##0.00"
    sql: ${sales_prior_7} ;;
    drill_fields: [core_domo_ticket_items.productname, core_domo_ticket_items.productbrand, core_domo_ticket_items.product_type, sum_units_sold_prior7]
  }

  measure: total_gross_margin_d7 {
    label: "Gross Margin Prior 7 Days"
    group_label: "Last 7 Days"
    type: number
    value_format_name: percent_1
    sql: ${total_gross_profit_prior7}/nullif(${total_sales_d7},0) ;;
  }

  measure: total_gross_margin_d7to14 {
    label: "Gross Margin Week Prior"
    group_label: "Week Prior"
    type: number
    value_format_name: percent_1
    sql: ${total_gross_profit_prior7to14}/nullif(${total_sales_d7to14},0) ;;
  }

  measure: total_gross_margin_d30 {
    label: "Gross Margin Last 30 Days"
    group_label: "Last 30 Days"
    type: number
    value_format_name: percent_1
    sql: ${total_gross_profit_prior30}/nullif(${total_sales_d30},0) ;;
  }

  measure: revenue_per_unit_d7 {
    label: "Revenue Per Unit Last 7 Days"
    group_label: "Last 7 Days"
    type: number
    value_format: "#,##0.00"
    sql: ${total_sales_d7}/nullif(${sum_units_sold_prior7},0) ;;
 }

  measure: revenue_per_unit_d7to14 {
    label: "Revenue Per Unit Week Prior"
    group_label: "Week Prior"
    type: number
    value_format: "#,##0.00"
    sql: ${total_sales_d7to14}/nullif(${sum_units_sold_prior7to14},0) ;;
  }

  measure: revenue_per_unit_d30 {
    label: "Revenue Per Unit Last 30 Days"
    group_label: "Last 30 Days"
    type: number
    value_format: "#,##0.00"
    sql: ${total_sales_d30}/nullif(${sum_units_sold_prior30},0) ;;
  }

  measure: total_sales_week_over_week_change{
    label: "Total Sales WoW change"
    description: "Percent change in sales from Last 7 Days and Week Prior"
    group_label: "Last 7 Days"
    type: number
    value_format_name: percent_1
    sql: (${total_sales_d7} - ${total_sales_d7to14})/nullif(${total_sales_d7to14},0) ;;
  }

  measure: total_units_sold_week_over_week_change{
    label: "Total Units Sold WoW change"
    description: "Percent change in units sold from Last 7 Days and Week Prior"
    group_label: "Last 7 Days"
    type: number
    value_format_name: percent_1
    sql: (${sum_units_sold_prior7} - ${sum_units_sold_prior7to14})/nullif(${sum_units_sold_prior7to14},0) ;;
  }

  measure: recommended_reorder_amount_5d{
    label: "Recommended Reorder Amount"
    description: "Calc as 21 day movement less stock less 5 day movement"
    type: number
    value_format_name: decimal_0
    sql: (${sum_units_sold_prior7}*3)-${sum_remaining_units}+((${sum_units_sold_prior7}/7)*5) ;;
  }

  measure: recommended_reorder_amount_4d{
    label: "Recommended Reorder Amount"
    description: "Calc as 21 day movement less stock less 4 day movement"
    type: number
    value_format_name: decimal_0
    sql: (${sum_units_sold_prior7}*3)-${sum_remaining_units}+((${sum_units_sold_prior7}/7)*4) ;;
  }

  measure: recommended_reorder_amount_3d{
    label: "Recommended Reorder Amount"
    description: "Calc as 21 day movement less stock less 3 day movement"
    type: number
    value_format_name: decimal_0
    sql: (${sum_units_sold_prior7}*3)-${sum_remaining_units}+((${sum_units_sold_prior7}/7)*3) ;;
  }

  measure: recommended_reorder_amount_2d{
    label: "Recommended Reorder Amount"
    description: "Calc as 21 day movement less stock less 2 day movement"
    type: number
    value_format_name: decimal_0
    sql: (${sum_units_sold_prior7}*3)-${sum_remaining_units}+((${sum_units_sold_prior7}/7)*2) ;;
  }
}
