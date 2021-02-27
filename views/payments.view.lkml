view: payments {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.payments`
    ;;
  drill_fields: [payment_id]

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${payment_id},${amount_paid_string}) ;;
  }

  dimension: payment_id {
    type: string
    sql: ${TABLE}.payment_id ;;
  }

  dimension: amount_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}.amount_paid ;;
  }

  dimension: amount_paid_string {
    hidden: yes
    type: string
    sql: CAST(${amount_paid} AS string) ;;
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

  dimension_group: payment {
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
    sql: ${TABLE}.payment_date ;;
  }

  dimension: payment_method {
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: payment_source {
    type: string
    sql: ${TABLE}.payment_source ;;
  }

  dimension: payment_status {
    type: string
    sql: ${TABLE}.payment_status ;;
  }

  dimension: ticket_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  measure: count {
    type: count
    drill_fields: [payment_id, tickets.cash_drawer_name, tickets.ticket_id]
  }

  measure: total_amount_paid {
    type: sum
    sql: ${amount_paid} ;;
  }
}
