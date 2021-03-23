view: dim_tickets {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_tickets`
    ;;

  dimension: cash_drawer_name {
    type: string
    sql: ${TABLE}.cash_drawer_name ;;
  }

  dimension: cashier_name {
    type: string
    sql: ${TABLE}.cashier_name ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: date_closed {
    type: time
    timeframes: [
      raw,
      time_of_day,
      date,
      week,
      week_of_year,
      day_of_week,
      month,
      month_num,
      month_name,
      day_of_month,
      quarter,
      year,
      day_of_year

    ]
    convert_tz: yes
    datatype: timestamp
    sql: ${TABLE}.date_closed ;;
  }

  dimension_group: date_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_created ;;
  }

  dimension: discount_total {
    type: number
    sql: ${TABLE}.discount_total ;;
  }

  dimension: external_order_number {
    type: string
    sql: ${TABLE}.external_order_number ;;
  }

  dimension: order_number {
    type: string
    sql: ${TABLE}.order_number ;;
  }

  dimension: order_source {
    type: string
    sql: ${TABLE}.order_source ;;
  }

  dimension: order_status {
    type: string
    sql: ${TABLE}.order_status ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: reward_points_earned {
    type: number
    sql: ${TABLE}.reward_points_earned ;;
  }

  dimension: reward_points_used {
    type: number
    sql: ${TABLE}.reward_points_used ;;
  }

  dimension: sub_total {
    type: number
    sql: ${TABLE}.sub_total ;;
  }

  dimension: tax_total {
    type: number
    sql: ${TABLE}.tax_total ;;
  }

  dimension: ticket_id {
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [cash_drawer_name, cashier_name]
  }

  measure: net_sales {
    type: sum
    sql: ${sub_total} ;;
    value_format_name: usd
  }

  measure: gross_receipts {
    type: sum
    sql: ${total} ;;
    value_format_name: usd
  }

  measure: total_taxes {
    type: sum
    sql: ${tax_total} ;;
    value_format_name: usd
  }

  measure: total_orders {
    type: count_distinct
    sql: ${ticket_id} ;;
    value_format: "0"
    drill_fields: [order_number, sub_total]
  }

  measure: average_order_value {
    label: "AOV"
    value_format: "$#,##0.00"
    type: number
    sql: ${net_sales} / nullif(${total_orders},0)  ;;
  }

  measure: total_rewards_points_earned{
    value_format: "$#,##0.00"
    type: sum
    sql: ${reward_points_earned} ;;
  }

  measure: total_rewards_points_used {
    value_format: "$#,##0.00"
    type: sum
    sql: ${reward_points_used} ;;
  }
}
