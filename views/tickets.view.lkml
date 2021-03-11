view: tickets {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.tickets`
    ;;
  drill_fields: [ticket_id]

  dimension: ticket_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: cash_drawer_name {
    type: string
    sql: ${TABLE}.cash_drawer_name ;;
  }

  dimension: cashier_name {
    type: string
    sql: ${TABLE}.cashier_name ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: date_closed {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_month,
      day_of_week,
      day_of_year,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
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

  dimension_group: last_updated {
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
    sql: ${TABLE}.last_updated_at ;;
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

  dimension: refund_reason {
    type: string
    sql: ${TABLE}.refund_reason ;;
  }

  dimension: reward_eligible {
    type: yesno
    sql: ${TABLE}.reward_eligible ;;
  }

  dimension: reward_points_earned {
    type: number
    sql: ${TABLE}.reward_points_earned ;;
  }

  dimension: reward_points_used {
    type: number
    sql: ${TABLE}.reward_points_used ;;
  }

  dimension_group: scheduled {
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
    sql: ${TABLE}.scheduled_date ;;
  }

  dimension: sub_total {
    type: number
    sql: ${TABLE}.sub_total ;;
  }

  dimension: tax_total {
    type: number
    sql: ${TABLE}.tax_total ;;
  }

  dimension: ticket_note {
    type: string
    sql: ${TABLE}.ticket_note ;;
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
    drill_fields: [detail*]
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
  }

  measure: average_order_value {
    label: "AOV"
    value_format: "$#,##0.00"
    type: number
    sql: ${net_sales} / nullif(${total_orders},0)  ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      ticket_id,
      cash_drawer_name,
      customers.last_name,
      customers.id,
      customers.first_name,
      ticket_item_taxes.count,
      ticket_items.count,
      payments.count,
      ticket_item_discounts.count
    ]
  }
}
