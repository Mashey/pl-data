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
    value_format: "0.0"
    sql: ${TABLE}.customer_visit_frequency ;;
  }

  dimension: percent_outside_visit_frequency {
    type: number
    value_format_name: percent_2
    sql: ${TABLE}.percent_outside_visit_frequency ;;
  }

  dimension: days_aged {
    type: number
    sql: ${TABLE}.days_aged ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [
      raw,
      time_of_day,
      hour_of_day,
      date,
      day_of_month,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year,
      day_of_year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
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

  measure: average_lifetime_gross_profit{
    type: average
    value_format: "$#,##0.00"
    sql: ${lifetime_gross_profit} ;;
  }

  measure: average_lifetime_purchases{
    type: average
    value_format: "0.00"
    sql: ${lifetime_purchases} ;;
  }

  measure: average_lifetime_revenue{
    type: average
    value_format: "$#,##0.00"
    sql: ${lifetime_revenue} ;;
  }

  measure: average_lifetime_visits {
    type: average
    value_format: "0.00"
    sql: ${lifetime_visits} ;;
  }

  measure: average_days_aged {
    type: average
    value_format: "0.0"
    sql: ${days_aged} ;;
  }

  measure: distinct_customers {
    type: count_distinct
    value_format: "0"
    sql: ${customer_uuid} ;;
  }

  measure: average_order_value_lifetime {
    type: number
    value_format: "$#,##0.00"
    sql: ${average_lifetime_revenue}/nullif(${average_lifetime_purchases},0) ;;
  }
}
