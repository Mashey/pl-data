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
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
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
}
