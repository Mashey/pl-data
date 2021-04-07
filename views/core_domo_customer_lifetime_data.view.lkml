view: core_domo_customer_lifetime_data {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.core_domo_customer_lifetime_data`
    ;;

  dimension: avg_checkout_time_seconds {
    type: number
    sql: ${TABLE}.avg_checkout_time_seconds ;;
  }

  dimension: avg_day_between_visits {
    type: number
    sql: ${TABLE}.avg_day_between_visits ;;
  }

  dimension: avg_visit_time_seconds {
    type: number
    sql: ${TABLE}.avg_visit_time_seconds ;;
  }

  dimension: customer_uuid {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_uuid ;;
  }

  dimension: customer_visit_frequency {
    type: number
    sql: ${TABLE}.customer_visit_frequency ;;
  }

  dimension: days_aged {
    type: number
    sql: ${TABLE}.days_aged ;;
  }

  dimension: first_order {
    type: string
    sql: ${TABLE}.first_order ;;
  }

  dimension: last_order {
    type: string
    sql: ${TABLE}.last_order ;;
  }

  dimension: last_updated_at {
    type: string
    sql: ${TABLE}.last_updated_at ;;
  }

  dimension: lifetime_gross_profit {
    type: number
    sql: ${TABLE}.lifetime_gross_profit ;;
  }

  dimension: lifetime_purchases {
    type: number
    sql: ${TABLE}.lifetime_purchases ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: lifetime_visits {
    type: number
    sql: ${TABLE}.lifetime_visits ;;
  }

  dimension: visit_without_purchase {
    type: number
    sql: ${TABLE}.visit_without_purchase ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_lifetime_gross_profit{
    type: sum
    value_format: "$#,##0.00"
    sql: ${lifetime_gross_profit} ;;
  }

  measure: total_lifetime_purchases{
    type: sum
    value_format: "0.00"
    sql: ${lifetime_purchases} ;;
  }

  measure: total_lifetime_revenue{
    type: sum
    value_format: "$#,##0.00"
    sql: ${lifetime_revenue} ;;
  }

  measure: total_lifetime_visits {
    type: sum
    value_format: "0.00"
    sql: ${lifetime_visits} ;;
  }

  measure: average_days_aged {
    type: average
    value_format: "0.0"
    sql: ${days_aged} ;;
  }
}
