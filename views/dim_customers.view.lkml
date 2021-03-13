view: dim_customers {
  sql_table_name: `fivetran-purple-lotus-warehous.dbt.dim_customers`
    ;;

  dimension: birthday {
    type: string
    sql: ${TABLE}.birthday ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_visit_frequency {
    type: number
    value_format: "0.0"
    sql: ${TABLE}.customer_visit_frequency ;;
  }

  dimension: days_aged {
    type: number
    value_format: "0.0"
    sql: ${TABLE}.days_aged ;;
  }

  dimension: days_aged_tiers {
    type: tier
    tiers: [1,31,61,91,121,151]
    style: integer
    sql: ${days_aged} ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension_group: first_order {
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
    sql: ${TABLE}.first_order ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension_group: last_order {
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
    sql: ${TABLE}.last_order ;;
  }

  dimension: lifetime_revenue {
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: lifetime_tickets {
    type: number
    value_format: "0.0"
    sql: ${TABLE}.lifetime_tickets ;;
  }

  dimension: opt_out {
    type: string
    sql: ${TABLE}.opt_out ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.PK ;;
  }

  dimension: referral_source {
    type: string
    sql: ${TABLE}.referral_source ;;
  }

  dimension: rewards_balance {
    type: number
    sql: ${TABLE}.rewards_balance ;;
  }

  dimension_group: signup {
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
    sql: ${TABLE}.signup_date ;;
  }

  measure: count {
    type: count
    drill_fields: [last_name, first_name]
  }

  measure: average_customer_visit_frequency {
    type: average
    value_format: "0.0"
    sql: ${customer_visit_frequency} ;;
  }
  measure: average_days_aged {
    type: average
    value_format: "0.0"
    sql: ${days_aged} ;;
  }

  measure: total_rewards_balance {
    type: sum
    value_format: "0.0"
    sql: ${rewards_balance} ;;
  }

  measure: count_distinct_customers {
    type: count_distinct
    value_format: "0"
    sql: ${customer_id} ;;
  }

  measure: average_lifetime_value_revenue {
    type: average
    value_format: "$#,##0.00"
    sql: ${lifetime_revenue} ;;
  }

  measure: average_lifetime_tickets {
    type: average
    value_format: "#,##0"
    sql: ${lifetime_tickets} ;;
  }
}
